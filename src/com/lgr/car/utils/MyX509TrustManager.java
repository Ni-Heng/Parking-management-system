package com.lgr.car.utils;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import javax.net.ssl.X509TrustManager;


public class MyX509TrustManager implements X509TrustManager {

	// Check client certificate
	public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
	}

	// Check the server-side certificate
	public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
	}

	// Returns an array of trusted X509 certificates
	public X509Certificate[] getAcceptedIssuers() {
		return null;
	}
}
