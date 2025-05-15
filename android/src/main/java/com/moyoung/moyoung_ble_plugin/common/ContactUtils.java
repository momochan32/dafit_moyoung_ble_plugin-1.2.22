package com.moyoung.moyoung_ble_plugin.common;

import android.Manifest;
import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by bill on 2016/05/19.
 * 联系人工具类
 */
public class ContactUtils {
    private final static String TAG = ContactUtils.class.getSimpleName();
    private static final String NUMBER_REGEX = "[^\\d+]";
    private static final String NUMBER_AND_SYMBOL_REGEX = "[^\\d+*#]";
    public static final String BLANK_REGEX = "\\s*";

    private ContactUtils() {
    }

    /**
     * 通过号码查询联系人名字
     *
     * @param context
     * @param number
     * @return
     */
    public static String getContactName(Context context, String number) {
        if (!PermissionUtils.hasSelfPermissions(context, Manifest.permission.READ_CONTACTS)) {
            return number;
        }

        if (TextUtils.isEmpty(number)) {
            return null;
        }

        final ContentResolver resolver = context.getContentResolver();

        Uri lookupUri;
        String[] projection = new String[]{ContactsContract.PhoneLookup._ID,
                ContactsContract.PhoneLookup.DISPLAY_NAME};
        Cursor cursor = null;
        try {
            lookupUri = Uri.withAppendedPath(ContactsContract.PhoneLookup.CONTENT_FILTER_URI,
                    Uri.encode(number));
            cursor = resolver.query(lookupUri, projection, null, null, null);
        } catch (Exception ex) {
            ex.printStackTrace();
            try {
                lookupUri = Uri.withAppendedPath(
                        android.provider.Contacts.Phones.CONTENT_FILTER_URL,
                        Uri.encode(number));
                cursor = resolver.query(lookupUri, projection, null, null, null);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String ret = null;
        if (cursor != null && cursor.moveToFirst()) {
            ret = cursor.getString(1);
            cursor.close();
        }

        return ret;
    }

    /**
     * 获取手机存储的联系人列表
     *
     * @param context
     * @return
     */
    public static ArrayList<ContactInfo> getAllContact(Context context, boolean supportSymbol) {
        ContentResolver contentResolver = context.getContentResolver();
        Cursor numberCursor = contentResolver.query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                null, null, null, null);

        String regex;
        if (supportSymbol) {
            regex = NUMBER_AND_SYMBOL_REGEX;
        } else {
            regex = NUMBER_REGEX;
        }

        Map<String, List<String>> numberMap = new HashMap<>();

        while (numberCursor.moveToNext()) {
            String contactId = null;
            int contactIdIndex = numberCursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.CONTACT_ID);
            if (0 <= contactIdIndex) {
                contactId = numberCursor.getString(contactIdIndex);
            }

            String number = null;
            int numberIndex = numberCursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER);
            if (0 <= numberIndex) {
                number = numberCursor.getString(numberIndex);
            }
            if (TextUtils.isEmpty(number) || TextUtils.isEmpty(contactId)) {
                continue;
            }

            // 去除空白格
            number = number.replaceAll(BLANK_REGEX, "");
            // 检查是否包含非法字符
            Matcher matcher = Pattern.compile(regex).matcher(number);
            if (matcher.find()) {
                continue;
            }

            List<String> list = numberMap.get(contactId);
            if (list == null) {
                list = new ArrayList<>();
            }

            if (!list.contains(number)) {
                list.add(number);
            }
            numberMap.put(contactId, list);
        }
        numberCursor.close();

        Cursor cursor = contentResolver.query(
                ContactsContract.Contacts.CONTENT_URI, null, null, null, null);
        ArrayList<ContactInfo> contactList = new ArrayList<ContactInfo>();
        while (cursor.moveToNext()) {
            //新建一个联系人实例
            ContactInfo contactInfo = new ContactInfo();
            String contactId = null;
            int idIndex = cursor.getColumnIndex(ContactsContract.Contacts._ID);
            if (0 <= idIndex) {
                contactId = cursor.getString(idIndex);
            }
            List<String> numberList = numberMap.get(contactId);
            if (numberList == null || numberList.isEmpty()) {
                continue;
            }

            //获取联系人姓名
            String name = null;
            int nameIndex = cursor.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME);
            if (0 <= nameIndex) {
                name = cursor.getString(nameIndex);
            }
            contactInfo.setName(name);
            contactInfo.setNumber(numberList);

            contactList.add(contactInfo);
        }
        cursor.close();
        return contactList;
    }

    /**
     * 根据名字获取联系人头像的 Uri。
     *
     * @param name 联系人的名字
     * @return 联系人头像的 Uri
     */
    @Nullable
    public static Uri getContactAvatarUri(Context context, String name) {
        Uri uri = null;
        Cursor cursor = null;
        try {
            cursor = context.getContentResolver().query(
                    ContactsContract.Contacts.CONTENT_URI,
                    new String[]{ContactsContract.Contacts.PHOTO_URI},
                    ContactsContract.Contacts.DISPLAY_NAME_PRIMARY + " = ?",
                    new String[]{name},
                    null);
            if (cursor != null) {
                if (cursor.moveToFirst()) {
                    String photoUrlString = cursor.getString(0);
                    if (!TextUtils.isEmpty(photoUrlString)) {
                        uri = Uri.parse(photoUrlString);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        return uri;
    }

}
