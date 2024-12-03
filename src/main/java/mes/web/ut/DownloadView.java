package mes.web.ut;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {
	
	public void Download(){
        
		setContentType("application/download; charset=utf-8");
         
    }

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		File file = (File)model.get("downloadFile");
		String fileName = (String) model.get("fileName");
		System.out.println("DownloadView --> file.getPath() : " + file.getPath());
        System.out.println("DownloadView --> file.getName() : " + file.getName());
        
        if(file != null) {
            String userAgent = request.getHeader("User-Agent");
            
            boolean ie = userAgent.indexOf("MSIE") > -1;
            boolean Chrome = userAgent.indexOf("Chrome") > -1;
             
            if(ie){
                fileName = URLEncoder.encode(file.getName(), "utf-8");
            } else if(Chrome) {
            	StringBuffer sb = new StringBuffer();
    			for (int i = 0; i < fileName.length(); i++) {
    				char c = fileName.charAt(i);
    				if (c > '~') {
    					sb.append(URLEncoder.encode("" + c, "UTF-8"));
    				} else {
    					sb.append(c);
    				}
    			}
    			fileName = sb.toString();
            } else {
            	fileName = new String(file.getName().getBytes("UTF-8"),"iso-8859-1");
            }
            
            String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
            
            response.setContentType(getContentType());
            response.setContentLength((int)file.length());
            
            fileName = URLEncoder.encode(fileName, "UTF-8");
            fileName = URLDecoder.decode(fileName, "ISO8859_1");
            response.setHeader("Content-disposition", "attachment; filename="+ fileName);
            
            response.setHeader("Content-Transfer-Encoding", "binary");
            response.setContentType("application/"+ext);
            
            
            FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ServletOutputStream so = response.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(so);

			byte[] data = new byte[2048];
			int input = 0;
			while ((input = bis.read(data)) != -1) {
				bos.write(data, 0, input);
				bos.flush();
			}

			if (bos != null)
				bos.close();
			if (bis != null)
				bis.close();
			if (so != null)
				so.close();
			if (fis != null)
				fis.close();
        }
	}
}
