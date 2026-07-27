Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D51390237
	for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166028; cv=none; b=o/Qkk4aOfvGKn/yOMk2u0oSRbkOFb2b/6SpLhBbenOeUSy3ly/4RnWqKXf+EVCcx2+cXhicytIvGQdvaOV9YOEzNTY3/xTop+kBtyktMcNTv6A8ZsWSIpHILzcRbef/Z1f5YRSXKznJnKOGAEY+iSHrLsqTLqFiGFdqZ1W+gw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166028; c=relaxed/simple;
	bh=RCMszCJlDtXUzAucA4CPTK6T8J9yaphFlk12h49frKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx8fysClFe/N1eXGZFulhdjIxlmDNbWnPme5ypWJXrxaKQtzB4WoexeknqpjszinY0d+CW9any/KntCXn4MTjPfZKNCZubsczIAAoVc9gu4GkCBNabxrU/H0qMYX3XNMyi/2t23QxPaQvooa6aoMapGg2vTVhHuSgXGEzWj82sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSIVHuG2; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSIVHuG2"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cabe9335f1so14651705ad.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166027; x=1785770827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5y4b5oEa+hE1ReLew0hc95qd67MVZsyBvHPuZveM4yw=;
        b=KSIVHuG2We1xJpXK8g7YWyzw6Sn6dQhMkz8k8DNVIin25pSGEEEkgmkYOvx7YGjxsO
         gpuc5NfH0QwLn2iHJuD+j/7k3rSIYZb2WdMf8/n4x/Glw1P+o8nnc2snF7fcc//F4CZw
         2k2lXCf4RQfqsySu0wj37U5Z5K0uiI5PRMqluZmvnPOJBSzexoi6p24bYiKuiiZ7Ey8K
         25rfkuswVX+NzO07Pc/Bh/xonjUjadS1vvG7mZTOLx/eiBjmnIg4TXhYyGqxfRFNzThx
         pZRnprE7C39c9BOR7M9Wl9fkRzl6ZYn78QBEQPAuQ6DJ3Hl/sP2o31l/DN1nxji/D0He
         eVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166027; x=1785770827;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5y4b5oEa+hE1ReLew0hc95qd67MVZsyBvHPuZveM4yw=;
        b=VN7ORnm6GEaCUmQSqpPLjMDqry2GZUOEexJ9bXPTJ43rE+Nbep57u9BiuxwSgC9Oa9
         A/3Ns9YLKQtrvYtepfBPx5rGcmeS/Yfv00rIQXwxAf9cpQ+uADl3ZfwK5scHZ8HstcYc
         ZDpc7SCdFFOyrSi3fQB6uVjZb2yM+UUiaHkU1WcLW94QzHpad0MQ0SX1ivTXM1mnLVsq
         id4orDQCOosa3pPHdJuT5hjyXIrCIHfAEGfPpdtHEMDa8kcH5nCLggxsQn/52fMrqD9/
         fulYI5f0/TkHAlQZYl7mr8vuqypP/enVlIytRtZdMTDL68ybt7ys3RYik5HVLt3n6hw7
         k9CQ==
X-Forwarded-Encrypted: i=1; AHgh+Roig6nZ+LWs1A7sITp3yJ1VUyntzJ22a/uejHc91JtH1ykupiqDnIn0wwtJ+5XgZ5RvF2xnT6liXGOu@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwZJmO3ant9MLoH8/3tfR+7ylGCsqgtEAAygkSG8mFNuyHtig
	zWL5lBIr981OBZkVCyJ7oX4PvdVowveA10DAQADZlg66Io8rSKbRL9A0
X-Gm-Gg: AR+sD12oU3w8WwQozZ3QLgRXiFcZYQnYsYvwVFuUQU1uVNcV37oZmeH2baJYDlX4ho0
	jc8U0Idz8QZUXwzA/RMru7DbSv3qvfxhnKPWEO5CGLrkyb1e2NTavpo+QlacC8csqeCCy5oRXC9
	5aybY4I8bzrSEG0ZltkJhJ4s3cAvt4FfqzlBIuaswPoLOuQEED4d6qu3FqU88txnT4vesoYUQUK
	POall12kVqbNutHwzLehDuPd6H8X2KGcqdXTBSgnT8D7zq0r1Q+XSt6DBo/bwUE7dD3YXf+9u6N
	S0d5Qke7qO34YZQaNc19qMWmhF9D993KTWTGx5P/6Z8Lnq+V5sYJFtkDBUgM8hkNptd4zUmmPlr
	g44V3fMeLEFEXjkh/DeFTokrEr5d0AgvoHe7/KM9vc52xy4qMsOgkERcbJNJyCGIakBPo4A==
X-Received: by 2002:a05:6a00:1798:b0:848:89ee:9de6 with SMTP id d2e1a72fcca58-84e88b4c1cfmr830748b3a.58.1785166026723;
        Mon, 27 Jul 2026 08:27:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532ad0f2sm3189796b3a.25.2026.07.27.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:06 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:07:14 -0700
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
Subject: Re: [PATCH net-next v3 1/7] ipv6: raw: drop unused level argument
 from do_rawv6_getsockopt
Message-ID: <amd0G_gICVRdcEsR@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-1-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-getsockopt_phase4-v3-1-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> do_rawv6_getsockopt() takes a level argument but never uses it; the
> level dispatch is handled by the caller, rawv6_getsockopt(). Drop it,
> matching ipv4's do_raw_getsockopt().
> 
> No functional change.
> 
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
