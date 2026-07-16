Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E74207A20
	for <linux-wpan@vger.kernel.org>; Thu, 16 Jul 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230269; cv=none; b=nXndfcqj2fYnVuo6a4DHOP4hK5vzH3s2R+10z/CmzaeYBRR6ZWaaJ9ue6SLfLznVwyzWTdipwZwI/27cCW+/ZBlxh+uShTtAj2IG/1MK8VSXPMZtco62Z87bOhckx0hzh/T4sxMy3NJbl99pacLOOyuUtpOD7lGLkXYr9nVgE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230269; c=relaxed/simple;
	bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7pAcEnHjbhTKBPY7h6mwcuLU0lhJzf21CanhHTaoK0UNlD/Cup4An/c8R81YHTTBcJEUE3W2oHBp/eMFPdTvQ62PjMvUH53QJY9i46H+voWvR/HxxObeoukZzx2Pp1h0xSNy1VbewBoAuGlQeDrZLNUu1npfiN4bb0YTyFqWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=nUFVskNi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="nUFVskNi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so43898225e9.2
        for <linux-wpan@vger.kernel.org>; Thu, 16 Jul 2026 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784230266; x=1784835066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
        b=nUFVskNi1dPSaAVgZsos6K5Gys/P/GX0tr99T3NHFzhcBRNNV7I8B3c79YxdZ34Uza
         FQKrDpPH+ZXbRQvanM18qTOBBeWcIcJxit/MVPtah5aUP7KORox8/F/WfaST1FYRxz1P
         zRT944s31yzRsaM7LBQ5lHaPOoIu19YhkhP5mcgwRVx8CjwnD8uDMyowYyUtCLNS6gqG
         01k5vVKx31C2ryY2C8qkpnhAFlbIQVgwVAItxAXDpURnu5FLYI+nn4vYfCoob6fI3mLP
         9knjAgJmXNJCTHe1Ol3b5CGTozun+g4TXSasAwhL4JexLMIiBGEhu3YE5THsd5zIMFWw
         +Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784230266; x=1784835066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WshbsU2q6H02/tJXUpUihHfMkSOWE4lYM+P8h5lLdws=;
        b=n/jTk+P3rT0ieyAgWFjTrS+0eWxXF59mg2B0duJXnz7m5swyN/jvFfw4exWrU6+dtE
         /OhsjUWxADnHWl7HbAUf2Yq2P+r6jj6znJ6F+A7qbsT35yexFf4tJppDnEFz5WDYmemr
         pITD6AU2EUUk23ipopPl9+8dVteC9I9+97N8lBD6YhoE6tLQ4Fb1oKjCaH5VoDYaXEQZ
         z5LBJlCXtIHtfUo+Vb9RteVQrR71KHdiinMlfctObuhCjVBLG74THO2+s5DaFu1VT1OR
         O8joD0a3njG1RCVxoa5viSRceM+ax9XJG92p2Hn2s8JPds7ejOmSyLnQ+qShKHTvp16f
         3yfA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1aHNeuxvBNP+OzhMhpiXtziNBgSyqWe1BVu6z6uLHI3oFP3HZLVxWV/zjqEj4jqRDum+viM7GUu2z@vger.kernel.org
X-Gm-Message-State: AOJu0YxeICVUNuHtYpD3RGi/QW4tqwUPPfCVaGHcP5CBkuiw/xHhQcZ/
	tojwsL13S9R/Rx0opwTEKzhFDKPNXPQydZ9NnYdyCr+018rpxQ9xMkMzsE/ct9k5pLxw
X-Gm-Gg: AfdE7cmR8g4TjkaKoHIgS70/WSgxw3tAoY0VbEAX+5F85g5cfGwqiM0H0PXvMyPT4Yp
	dDMlWCR7ThemVP5oCeI6PrBx781+yFUTcptQLCBxzpla3F+DHGYTbGvJBxp2LD2zhPmV5gMnNes
	Q7yhSP6BU5CfhNQr1o8QY9FGpCtOHnHX/VlYxzW/gfF/ApVEBaK2bNwEHodubwEocjEL1f7k4W/
	xAWN4iEEUIH+Tn0RF0Apviw9Zam3asaj/zaEHKvUwhp7QduQkCIHBYu+TcTVyo+ReXfgfIYa2JB
	NA7UYU1Upc9ilEPjWeSzeIUrPE7sxunxIsCTB77gBB1Z/fUBuoNhYYV4tSKpKS6thBcIlgmSeI7
	91ciCI6gK+fw32XTvoFRxoyP7SB/KhlZ921qQxn8tmqKHEJLcwGV/aWyoP1kw8P3SNrmjMATMVY
	QPLLWF7FpQHTRjc3xGxwY7Amb0P5iZYrZjkAJIAfD2dn9zxBu5XktRXoZ4PYXqq+xMpKFzwcx93
	LDuBzn6w0la99Wa7sz6Sahk
X-Received: by 2002:a05:600c:83c6:b0:495:3a61:b67e with SMTP id 5b1f17b1804b1-4953a61b766mr125503845e9.23.1784230266106;
        Thu, 16 Jul 2026 12:31:06 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e7f7f7sm77535685e9.2.2026.07.16.12.31.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 12:31:05 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: llsec: reject frames shorter than the authentication tag
Date: Thu, 16 Jul 2026 21:31:03 +0200
Message-ID: <20260716193103.30558-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709131246.44517-1-doruk@0sec.ai>
References: <20260709131246.44517-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will do both in v2, thanks.

-Doruk
