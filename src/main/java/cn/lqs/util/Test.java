/**
 * User: LiQingsong
 * Date: 2019/5/11
 * Time: 11:34
 */
package cn.lqs.util;

import java.io.File;

public class Test {
    public static void main(String[] args) {
        /*String str = "1,2,3,4,";
        String s[] = str.split(",");
       for (String i:s){
           System.out.println(i);
       }
        System.out.println(s.length);*/
        //想命名的原文件的路径
        File file = new File("E:\\projectTest\\test2");
        //将原文件更改为f:\a\b.xlsx，其中路径是必要的。注意
        file.renameTo(new File("E:\\projectTest\\test3"));
        /*//想命名的原文件夹的路径
        File file1 = new File("f:/A");
        //将原文件夹更改为A，其中路径是必要的。注意
        file1.renameTo(new File("f:/B"));*/

        String a = ",1,1,1,";
        String[] b = a.split(",");
        for (String c:b){
            System.out.println(c);
        }

    }
}
