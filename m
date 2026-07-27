Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A40390CA6
	for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166031; cv=none; b=RBr3KaAXjU3iwrKnWcqAg/+Hbxsntb5C3J6P9zhSt6gx8hEIX3EpG5eSVnR8K53dUhm3vKv9MG1zKh5j6LZz7gSoMyTrcJjUQLKVLl8FKQyjzNl5yefZ+4bHHpSSWvoTpkm6NQ/gY1zEJYEv2nlPKsnMvDAPMP9AwhxAwolsuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166031; c=relaxed/simple;
	bh=tNEsctqLU+NNG/v7EAor3xQ97G6fAwAace4TihTp1Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2gr+es+eDW1BBTVB4ZjhTV2v8DMG8EJ2uAnuCuhxB0XZ0wYhpZXYJTz8BKqyV0HXkQ+0CGlM3TO1JHmHjoPWiHLJbbxOQGOyfYxv81z9yov5N2/v/xc5CmlWORBsMU8h+tiMq5J/9rlzm1/mwohOiSw63DydXckpdGYCXVx0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLo8aEna; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLo8aEna"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca034c989e2so1508039a12.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166028; x=1785770828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VlC8romriLwiw5lX4tM+10Qn9Ku6TgWDoqPfgLWOFsg=;
        b=tLo8aEnaNOngSy75r3TQs5J7Cypwu6FkSOaji8+o8lS3ittOt7TJAyNTIqNcG3UnWb
         utNsWpVEIyLxl0HMeeLpZpFji2alEJyth0vGJD2ZM+DJy5P3AsOwKTyyoM3N7yyTBKZd
         gXrnRCKSki273/9lLOKH+YSb8gbS8ut/W3LCWA2J52QsXJ2on53avM68YOYHFw3VvL6T
         8CKFuFc2H3Sbe8B8MQFcqws20ZhbKbM2Vsktx8sgjRFPK7MhSZ39cPvXukG8tPbLC+La
         AA8PxtHt8rhEM2xfrJU/aU7RixeiYFhRTmSiIrMgyciR201uUdqGgHoA0GkyNgyqsEMh
         +aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166028; x=1785770828;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VlC8romriLwiw5lX4tM+10Qn9Ku6TgWDoqPfgLWOFsg=;
        b=KFiCCogPTpxU2ZE3t6SdfDXAR/+i28HEt1D4ymSAQe+xBcWMYEKjocd0h+aqfs31Gq
         AA1R1ljenB12RZGrHmVpeHEBcmTWwB4WKPqiFOEbgBAzyDc8U/9vu6+F3H0eXJ4b2jkJ
         2M6PYCs65Xls7QVg9iQ75goNYwAdz2cBppP0XITg7E6oOmWcEuYDlWDp+H1ZIEI3yQ8M
         9QDWemcM8wEJp0J3V6ZPMtMExbUUqHmdCmygYNpFZMf0gu6VAjbEZ2kbej6LJ5F7kYQ7
         Z8PLhDfIv4u0U1nkYfGCEd764XNK5qzm2hzt7buQyNXOFkHrpe73Zxx5hKzUITgLPr1e
         M9TQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdM8VAN96wg6j9fy+PYahhXGLzsimwZsD+YSTDNbJOtLdpmC4wfDoe0NcS37Lsb/nbxpAZqMK1l02C@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEluydEz26FkSDZdnFV/KXMjrgAUiypHN6Q6l1gznkfdmiG5f
	BGQx1a0PAHg7Xop16isGSjO/egPhes3xAYaWM62GJIdD9Nsei2wsIg0Y
X-Gm-Gg: AR+sD12kuRTVfideu7RZFwnoUeinglyREAK7MK4sLeUXzcJaW361Rw3c6RO7nDOuXwR
	o1KycEtYTWm0CSJDRGBzBrOIYRkecWfKQyM6lnlOlrEUkT9zlT0XURSX7dbQGYbeSTG28QRehMn
	4XCMTOLOkYMNq5W9L8G7S4mNkboTArEKI19HhapDcC2O3XCntpxbU/zqhGcKqbqrWPzJJOKBlzd
	NnGFqttAdfE0PuwqOxLmH5iW/E3UYUvmX15l/9NyQVIngqlM3HAKyWVZXRXmEz3SVFXy6UNml4I
	7RMzaBr1v2m4uYf8uM+8awx7YKoUbTul6aGyRqxkCCkYLB2kb4AIlW6EbOkeZRLb376OTd2WPTC
	H6qX2PaGvnkJGSNhwje23MmwTastqvWQcPh5/lC6Cu4gOaJ8xNqZ9HP4XImHVVzMENCJmtjY=
X-Received: by 2002:aa7:888b:0:b0:845:18b6:1154 with SMTP id d2e1a72fcca58-84e5940af34mr7293602b3a.8.1785166028466;
        Mon, 27 Jul 2026 08:27:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b282asm3558622a12.18.2026.07.27.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:08 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:24:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 2/7] ipv6: raw: convert do_rawv6_getsockopt
 to sockopt_t
Message-ID: <amd4Da5CKqDuNT2d@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-2-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-getsockopt_phase4-v3-2-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> Convert do_rawv6_getsockopt to the new sockopt_t model, mirroring what
> we have in ipv4. The overall goal is to move these callbacks gradually
> from __user points to use sockopt_t, and this part touches
> do_rawv6_getsockopt.
> 
> No functional change.
> 
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
