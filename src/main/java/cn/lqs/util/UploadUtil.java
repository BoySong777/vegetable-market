/**
 * User: LiQingsong
 * Date: 2019/5/9
 * Time: 12:13
 */
package cn.lqs.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.UUID;

public class UploadUtil {
    public static String uploadFile(MultipartFile file,String path) throws IOException {
        String name = file.getOriginalFilename();//上传文件的真实名称
        String suffixName = name.substring(name.lastIndexOf("."));//获取后缀名（带.）
        String hash = UUID.randomUUID().toString().replace("-","");
        String fileName = hash+suffixName;
        File tempFile = new File(path,fileName);
        if(!tempFile.getParentFile().exists()){
            tempFile.getParentFile().mkdirs();
        }
        if (tempFile.exists()){
            tempFile.delete();
        }
        tempFile.createNewFile();
        file.transferTo(tempFile);
        System.out.println("保存的文件路径："+tempFile.getName());
        return tempFile.getName();
    }
    public static void uploadFileToServer(String filesPath, String oldPath, String newPath) throws IOException {

        String[] filesPathList = filesPath.split(",");
        File mFile = new File(newPath);
        if(!mFile.exists()){
            (new File(newPath)).mkdirs();
        }
        File temp = null;
        for(String filePath:filesPathList){
            if (oldPath.endsWith(File.separator)) {
                temp = new File(oldPath + filePath);
            } else {
                temp = new File(oldPath + File.separator + filePath);
            }
            System.out.println("判断文件夹是否为文件："+oldPath+filePath+"是吗："+temp.isFile());
            if(temp.isFile()){
                String newFilePath;
                if (newPath.endsWith(File.separator)) {
                    newFilePath = newPath+filePath;
                } else {
                    newFilePath = newPath + File.separator + filePath;
                }
                FileInputStream input = new FileInputStream(temp);
                FileOutputStream output = new FileOutputStream(newFilePath);
                byte[] b = new byte[1024*5];
                int len;
                while ((len = input.read(b))!=-1){
                    output.write(b,0,len);
                }
                output.flush();
                output.close();
                input.close();
            }
        }
    }
    public static void delFile(String path){
        File file = new File(path);
        if (!file.exists()) {
            return;
        }
        if (!file.isDirectory()) {
            return;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
        }
    }
}
