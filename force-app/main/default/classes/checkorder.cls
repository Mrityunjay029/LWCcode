public class checkorder {
    public static void getCSV(String csvname)
    {
        
        String endpoint = 'https://www.ftp-api.com/ftp/download?fileName='+csvname +'.csv';
        String username = 'if0_35652449';
        String password = 'CcPbziKFaubwxN';
        String ftpHost = 'ftpupload.net'; //Host will remain same if you are using same hosting service
        Integer ftpPort = 21; 
        String ftpType = 'FTP';
        
        
        // Set up the request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('username', username);
        req.setHeader('password', password);
        req.setHeader('port', String.valueOf(ftpPort));
        req.setHeader('ftp-host', ftpHost);
        req.setHeader('ftp-type', ftpType);
        req.setHeader('path', '/');
        req.setTimeout(30000);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        if (res.getStatusCode() == 200) {
            // Get the file content
            String fileContent = res.getBody();
            // Get the file name
            String fileName = 'sample.txt';
            
            // Log the file name and content
            System.debug('File Name: ' + fileName);
            System.debug('File Content: ' + fileContent);
        } else {
            System.debug('Error downloading file. Status code: ' + res.getStatusCode());
        }
        
        // Get the file content
        String fileContent = res.getBody();
        System.debug(fileContent);
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(fileContent);
        List<Object> filesList = (List<Object>) responseMap.get('Files');
        String csvContentBase64 = (String) ((Map<String, Object>) filesList[0]).get('body');
        Blob csvBlob = EncodingUtil.base64Decode(csvContentBase64);
        
        String csvData = CsvBlob.toString();
        
        System.debug('CSV Data : ' + csvData);   
        
        
        
    }
}