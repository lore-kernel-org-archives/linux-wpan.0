Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794031600;
	b=0x80lHIYlj5k/uLaFORekHuwvBB+MjigixS4sCPe8O2qFlCD2mR8/LEqXM/qxxzc93L+
	 QpXSHMjQ7oagI8g5znP9y1EE8K1FI2gQt8Rl52aMsG9wy6ea1VubFsLq0YZRxTaPEZCC8
	 NC9NOXJ3gmDtqFnL2hKHwbhMUFbwyU0LGV+h2dcahCyNeGvEPfAFrjDoi+F2rTwKZeXpt
	 /XxzcIKOHk3HFSR/l7qKTrr6/FFc5eua17yEayNwGb4JVfJGmSeUg8pIqfe1TwqHJoa6/
	 bULtVVj5UJB0Be2PHavc6Hy01TOp/rZp0OYT+Te22mj0j8tKg14e44mXObQpJyBOtDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794031600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
	b=cVk6ZxiZiswCrOJrFzidsOIwK9IHP/YUukFp7+mtXGhBN7P3ZRP4I/hG/0K5Zm9Dpkvn
	 4hP0ueqGHQnkXbEA/2Kipo4gF6qPYgPX4xeeUh7SW5gm54BYgauNsEXPnusXaoz1mHa7i
	 yPJPBBAd7Qzwp8wzJajBBnIyajoklcUwuOUq79e1xGXwljLlv/+pcL0qYG7s1M+mrneMZ
	 f8LON9i65H7gLymbfvcoEYsuUMarZpHExWz21dhdVgO2Gx/oUVVVVcHuFAg4ydnhTDCl8
	 COWZF2GxzueDmRfGEpi5ub5XkxZn7BTyrhGa1E3zX2ApkMWi77f5ssjYgqJl7L+5uYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="q/7dWNdw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F3606A32C
	for <linux-wpan@vger.kernel.org>; Sat,  7 Nov 2026 06:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8F3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q/7dWNdw
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43bf9548df4so1215941fac.0
        for <linux-wpan@vger.kernel.org>; Fri, 06 Nov 2026 22:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794031599; cv=none;
        d=google.com; s=arc-20260327;
        b=jz6P4tDud9SF4auMjnUMfjpek/A1k1MSVlNLfPvaqxNDC1Wgw6Uvwzd9t9eUFsY+pB
         CDUUK9W+Yb4z+CK7oPX38ZUUJbY5LM7l0rQ+DZ1I2P3mxxFXCD7DxLzLMiUMEgJV/BWj
         uVBWgfKZSsfCBdLI1UcqLL1k6+bTIBkiL5p4c4HoZxntC0S9aIn1WoztMiGvrqY9YKGa
         x1mxDIb0yvo1NAI+YHkqpWZlSrynRqEc2kN/7Sjtm2ADVdt0F27N/xqUHqq7QnE2goqX
         cr6DtHgaHAQZLUrcGEX9QmNESLTtWYeoZNNrox1Wn6TmJ6EAsVcLTB4mreR9E9OBzjED
         7hjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
        fh=zTImkl5+w+xKhxiFO3S7qxCZye9ZcHW2Zj17qGFCw6E=;
        b=SBg2TJe3I1Rhwp1Fw1dQsEF7DHKJraw1521WdIebrwCvT7K+DaK57+dNmQpLC97L3M
         ChTyDKW/+fUQazXGi0gSv2IpX95fPJtX0hcH1SMGzCd113xOLo2U6w5A2eDGrobXF31k
         pYSA0tnfKTAmfCrbqJovnhKj+PtAhXeKhU0gSAWnJbk3llw/88J5FbLPkuC2el9sQq9a
         /tKeoW39QxWfL4oelJdIN+loEo50QQajMSRvfG551mOoeSrs+KvFBpy6X9MaTdEIdfoc
         YR6WVr7UDYrso5h05WHnjYMTh0HnJqvtwHRSMWM4V2GaNy+mBoFzmYeaoK+7bk0Q0cHq
         ekXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794031599; x=1794636399; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
        b=q/7dWNdw003NwmwZXnvlv7VO365y8zNcVd0MPxkKzeNaX9Ksq3LCD/80d4DKzhDCF6
         IZRpO5bWCHMSSEhnc9MqyEmf6uSyzj7jgnxm3F8x/63kXS+xlH2Z3d+WNLWhoRF7K+FB
         N7/f8hAefAwArQNrLO4FWfhPm7MKhjnRBauNRLKOFiBwPaOTBKIv2EzTrP2aNnOEQux5
         vYFE3nlTQu9aAAHQo92Gxk+ag/bFRJeTY24X2zRgrv1M4igD5iKGjefTDmJ3umUdmeKG
         735kVziiOc5bYAPtNH2kthGmUEXnjL5+nymlwpZPrYIIffyTAi/hA9AsU2kTb3Y+lo11
         U6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794031599; x=1794636399;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
        b=rTRA2mOW0lFZqUKLQhvmh8VHgVsA/A2j1aAgBF4rh5/x13t3hHmApsMQabGwnBJfML
         TgTSuTydbBN/NM8oeZS241VUcSIbQhDYfbGgDuGUi6zjDz8lfHCBSizNVev6R3vghUoY
         ATJs2OuJ8J6ln8M8s0gfdLaLb6zQq/iX/FKtNQtcrCI4SmPTUgMokrscWc7p0ns7hGwC
         Ljbp6zNCjkMzyJHz9rfb52hAQUBgwyVDxQu/39N4BP+1AuBQV9Mr0G8J0WK4NytdS940
         8sZw7A1BneL1QjMa9jakRdGQj6hiTW2HcXg/Y8T5+WuNcua9wFnJrnDE/NuNDHPJCSBu
         qIkA==
X-Forwarded-Encrypted: i=1; AKwUvBwXJ/qjvcPIMHwsr1GH7MVxdtI7XNrmEvOUdopYk/zexmK/oZ0J6h6nqj0JQwuaWZZr9foKXOO5zXDX@vger.kernel.org
X-Gm-Message-State: APuU4Z9t63zBOhT/rzldueElyekx7gK9LBtaNzjToLH/mPVgEcRJBGAb
	CMiJ0o6oh+csnWsx3moW9vbA9kecC4cCwsgSEt2R7Fm8DH3WFMQsAjBwM9OBhLpv1QWDjaqCpZf
	W0KsurqGZ1toxdARd2ObOWEgJ6WlvXrY=
X-Gm-Gg: AYBFou3DppcVVEbG+gd+unLfgMW9a1uUSFvL1pbxpBDyW23lK8DdlLjqgU5zFgUq6KN
	qnw88DblrfEpNaS7e6lVSt1uGuqJcprUUfFEBGwe4mgfgKWFlnv7F/HCHY6VdzCEJHHYNtTVEvo
	Z1M/X9Nb0F9vYLoSiNEczKZ3wE0TXizdJKb8tRimITkPu2ImqZd3dkmsh3Fs7IT6rtvZ1Qq0gQz
	PQbYOEmb7ifVVka6p9Myn0GlVNi5l24zUzRrzBozOXSKwJSWQPYdzr9JQyUxDnm+1nx1gTgx22I
	pGsKX4i7JlOitNtDSZTsAJE43l11PdWLv6vvRqMA7hutoJI14xlSeysRyOhb/ulhm9ePUAOSez6
	d2b0xrWacE0JVrl6UAkBGeFzgmq/6Z6t2sITllsewWbnEbGKU6rxFegItgw==
X-Received: by 2002:a05:6808:23cf:b0:564:3bc3:4605 with SMTP id
 5614622812f47-567e1535fe1mr3335044b6e.40.1794031598913; Fri, 06 Nov 2026
 22:06:38 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 6 Nov 2026 22:06:37 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 6 Nov 2026 22:06:26 -0800
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Roshan Kumar <roshaen09@gmail.com>
Date: Fri, 6 Nov 2026 22:06:37 -0800
X-Gm-Features: AclHuK99jKENmsQSNXDnKdu7CcWNmvDQnx-3eEPjLvKurMnwi59_003exdfncjk
Message-ID: <CANphZRNSXy4tQ9jO7RT5g2X69T-CapR3-sSood1qJfYTRUE8ag@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yousef,

I independently reproduced and tested this issue on current wpan.git
(2b4707a149a5). I also prepared the requested rcu_access_pointer()
update. It passes checkpatch, targeted W=1 allmodconfig/allyesconfig
builds, and 200 KASAN teardown rounds without sanitizer findings.

Are you planning to post v2? If not, I can forward it while preserving
your authorship and Signed-off-by, adding my Signed-off-by as the
forwarding submitter.

v1: https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.com/

Thanks,
Roshan
