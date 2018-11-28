package com.android.simplSdk;

import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;

import java.util.HashMap;

class MapUtils {
    static HashMap<String, String> toHashMap(ReadableMap map) {
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
}
