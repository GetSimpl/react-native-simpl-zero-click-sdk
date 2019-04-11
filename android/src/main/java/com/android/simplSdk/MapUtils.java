package com.android.simplSdk;

import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;

import java.util.HashMap;

class MapUtils {

    public static HashMap<String, String> toHashMap(ReadableMap map) {
        ReadableMapKeySetIterator iterator = map.keySetIterator();
        HashMap<String, String> result = new HashMap<>();
        while(iterator.hasNextKey()) {
            String key = iterator.nextKey();
            result.put(key, getValueAsString(map, key));

        }
        return result;
    }

    private static String getValueAsString(ReadableMap map, String key){
        ReadableType type = map.getType(key);
        switch (type) {
            case String:
                return map.getString(key);
            case Boolean:
                return String.valueOf(map.getBoolean(key));
            case Number:
                return String.valueOf(map.getDouble(key));
            case Null:
                return "";
        }
        return "";
    }

    public static HashMap<String, String> stringToHashMap(String stringMap){
        stringMap = stringMap.replace("{", "");
        stringMap = stringMap.replace("}", "");

        String[] pairs;
        if (stringMap.indexOf(",") == -1)
            pairs = new String[]{stringMap};
        else pairs  = stringMap.split(",");

        HashMap<String, String> map = new HashMap<>();
        for (int counter = 0; counter < pairs.length; counter++){
            String[] keyValue = pairs[counter].split("=");
            map.put(keyValue[0], keyValue[1]);
        }

        return map;
    }
}
