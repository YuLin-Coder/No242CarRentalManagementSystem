package com.yuanlrc.base.config;

import java.io.FileWriter;
import java.io.IOException;

public class AlipayConfigInfo {

    // ↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2021000118651004";
    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDCEaA1cSWjQNqQeSHJtQR0MA3ZKmvCv18yXLZmF7h+6dzZKcPAZz6ch3YYTHsPSAtxYPOjwhU1dFvsDG+Zd+u+5OSoxKpxiExZ0sPStOU3K3huLDPufZOYgrZ7ck6TL0uQ7ncLBHPN3hPPvvMfLYeUx9n5GXZQWzd9MlaKfY6t7QjEG0q5XsCGdB/TdOR+TWBCyBUpcuNxpfDyRztSKL6h1temMxV0XRgW0JcePn5YbPkPkKditemYef2SY2XCPcUMQ4K+Yl7nruRpAdM0pjgqvZ4jpnTg2sOD2xvJnTkdphtdw0SvHzgy9IFnbjvg6PonlOKhbggT0esdqsmjBJbpAgMBAAECggEBAI5JQf8sz/2b5SObzEwJLhTJzr10PsHwcamJFCpSJfDXIhcOafk9OUimgM1b9bXEiq87+CYOfGJOx76Pd5s7s1qok4Wxe4318pTA1NY9zvjeJFQSkJjA9WASJhzoN/ft6yd9z0YCo61Cr5/XToWDai6JQKVEJ9zOpCZkq9KqL9wP7oeoaXsVPgigtOqOhNPBrQypcmb457dGwyAn7X7A+4GrTM4As1+qWNrtLbkZ6qnKWJjBMb25UJurGzyVuiPqD77Af80u0PpxIp1M82YjSysMpgxmCzWAlzbDd227SccCGyt5GLL3qMV6Et5q/Gbsd+813cpdFQoUVwhPEPSJawECgYEA/etOC8QVN19JMJoF09LLoRWD0Fwl7l7FTmKPO0TJp9u+0c9UEeVPDpwUnn87ZDTZoQ77DTVsEC5NcefWKMte+KY0RHAm8nacCRioFhF4i8fFcyo7wQceiOcM7LivHgVgyoKayHInhsV5HpnfNnLShyf6/2aGzpKubzvog6AnVdkCgYEAw6jC7N7PkPFil0b4LG/X96ONLdu4pkOigsrRz1IY6PZI4EWCsogsPidda74Nv467tHnguKsSYqHD/70sKXzlG7xWHFDnQ9vMmVJVtRC63QRLsOYF71fNZuPMwUaDXGlvUbM69g1gvK8+Xs30Jhm5EeVeQPSKNGenX2KrXjDXT5ECgYEAzRjriYVwvbExpRhD7L0vzYVbW0mTOd9C7/WcS/tcB0Hv9/jHp0zZdquL3BpZFq+5ueYn0pt8FfXQiFkDGyBqLd3SChWs39v+XTqVSn4CKKXMTyGl8lyVxW8beXoTuOQPMoQcEhxi4PFQy+7t5UUJ2DHrA7EE4oaIb0CspuUN4MECgYEAm6gk+yD/bMY8szEIuwF3hVGePX9x1QQ1w2vros4jdyKIM7PZGINw/zl9/vtCIMVC23+iogenJsSfE1PCUHdGJdydfQV4FupESS3Rda0LnE2QkflNe24UwOg1uwWH9/sBTrQSEjHuZe3c5rteovkP3QbnBzIEyVA1PZNX1iVxBaECgYEAqe8W6uPja0UsUB8in7Bhl0WhvezNcmAJmzhdt0Fcs0zzeO6h/C4owdwXO6Ub7o/EBWBDRe50Ouyh0xPJUhDHn/DVTsNXMB0B2mo/o+6IHDxYbUnoQc2aZ9jmgun10he0GRkCGB9Ab873izgRJxAmYv6OpOHYyNBR6iQLRgE4nYM=";
    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm
    // 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt/OQ7eCc9dtQOKsKDanRxKi3apadH9e7bzH1OWlDmTkIXDphlPqP9A76uzTHbd8RhZsmrYeropc4J1y0scLltXEOBSPgiRl4m4gykfuNFmNQvKhdPE0ou9DSLzXk8l6XEB3evQm8rIzlQKBb+0I3aiaU5AsR6nvC3bLtYAC6nPHe+WT2PzhIvwZ/rJlFPoO2452qqx5eDboP2nq6xIpotJbV7KpQOr3jIqP4d3JiCcrw4Pa6vNz62C21CUk5XPiu72VQd7YW6yR6OT2jy+Esne2NC+MFwoEm8pUqwJzXzCv35QCDBok9WgvDrw0rPBXM+kLojvRDv5zJ9aiIuN10xQIDAQAB";
    // 服务器异步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    /**
     * 返回的时候此页面不会返回到用户页面，只会执行你写到控制器里的地址
     */
    public static String notify_url="http://hc4fjnu.nat.ipyingshe.com:31427/alipay/notify_url";
    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，可以正常访问
    /**
     * 此页面是同步返回用户页面，也就是用户支付后看到的页面，上面的notify_url是异步返回商家操作，谢谢
     * 要是看不懂就找度娘，或者多读几遍，或者去看支付宝第三方接口API，不看API直接拿去就用，遇坑不怪别人,要使用外网能访问的ip,建议使用花生壳,内网穿透
     */
    public static String return_url = "http://hc4fjnu.nat.ipyingshe.com:31427/alipay/return_url";
    // 签名方式
    public static String sign_type = "RSA2";
    // 字符编码格式
    public static String charset = "utf-8";
    // 支付宝网关
    public static String gatewayUrl="https://openapi.alipaydev.com/gateway.do";

}
