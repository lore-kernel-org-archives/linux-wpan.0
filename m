Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2D3909AE
	for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166034; cv=none; b=Awt7PS2pLPe/pv/4ZH9ET6m2uofgQx9X0bvltSy/IFCubF329S7V+5oetHvCPQJy75kTgSvi8YFbmvPvGLkMsL02mdUVK8R9sWNR1ouPF2dy1k7qCbrx3RWA5wYp/Dr5TsmYt7PlgLcf0vLV48bM22w0EBJsNS73lEW/vu7Cez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166034; c=relaxed/simple;
	bh=vCyBZzr8XG5fTez25O0nwZsdRsvkch87OhUwThfBK3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVKsG3lz0FQZvvADpykZ3c6CtSdUQ7UuraD5R1a4PDQtTw3ejsO2hbA6WM4N8mHgh4GFxVBOx/+9EVxchfLAvTFTQjbBrTQtRY+AaaQnyKnLayC62zZCk2/p6GgG0V8Rd3SG6QuDAK9/vrZwP/aZYYCm18Z0izExKEYgfWo6Iug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz+fa25R; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz+fa25R"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38ed4d37526so1509221a91.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166032; x=1785770832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAjxxzf5O6bgYjOTSZSfouQee5mJtyXCeTi3IXQgpWs=;
        b=Lz+fa25RJXHRCs6DF99cRN7MDbemvvD1xhuJKCrZmZfbDA0M9n4P0SsiOFl/vnb4Ya
         jez7xfQQS1ZyXBI3DuQCP+ZyU7lxbApOTke+BE2qYPBd4KhApbUEU79o1eR9BqPwC6co
         sXYOOPd+lgq3R1wwmIqSe/cnS++weE+mqlbf5FEjABM089BiR2q29drG2pKG6D0CBQUR
         omDHKs6D/uWM/hcHv+tcXJvDOG727z4cb9tqHZ4mwgFVeHS1l4aWtkC9PqUyNMn1/QGH
         E9Y6YinaxqHzzNpcrSWCLuWG8H5iZ8n9+zY47jX4ZkEsBsl67z841e3XAfv11yceLv9z
         K5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166032; x=1785770832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tAjxxzf5O6bgYjOTSZSfouQee5mJtyXCeTi3IXQgpWs=;
        b=Hw7Mp7ibUHuRP5XijbjStHMVRQMQKf787ZCfZsuA5hyvdfsqxwmV5x63kwFFy7JRsT
         n+DQi4xMS+dUoV0rQP6rCV9SNr7yXYttjsKPNRsJ/jQlfoIBvKtFrvZFuMNzb+hpSG0S
         B2BFxXCN7VNiIzBda0HgVg/ZtOMZ9ePuqTnhcalvCEhkHlB39pNCmg5aLaTmZYOyUwOO
         qkV+g33P9EAMwkxCKTgKi/LXHW7vTQAAjvH3tU5PQvoT5yg9E+L9PtQaQqS+dc+QaWMc
         erpc8mQ7wx3u020oshdlbnFVuuxT6izgu8G0Rbo2x/0YZ3e1BMwxCB4vx2AYxOnHjlmH
         dOeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpkz7+KfvexlXp9KFw+SJL6Pv6ZVQBnxYNCKPpSowAh/dRvib6OYUEotjEZkpbjUAeBBw8eP5C1uIcS@vger.kernel.org
X-Gm-Message-State: AOJu0YxnalvzG3w4jDMxnFtxW4CrWtqI1aS07Fu4fETXyTYErfwr1xi3
	PKAKQLl18rQOxkr2EVNkCMZ0r/xMnOIcUkwYCUJ8h6HXNWRlCMwJVpFO
X-Gm-Gg: AR+sD11+Xa0anJfoWkaODcD2tlT30CGRvI8hgJyyoeWJTGVlsdfyjreXbyaGaTcTYOx
	L/wcm5G346kRc27ZSA7jb8TSjiVV/iVgpvMU4djWu8F371whTivLeh7F+8uEikI8Ts4rYNc8W3L
	RymBG6C6jYD8ckIi+J1UCNtvH4F4eYjFCBDlClOXQRI7406X6frMx4rkEjjCKHByl8R7flw9OyX
	Mii983KAdg8VXtAGxttDN11Rh3N/AdpQ0wC+T8U+p/Kq3njbCQ1S2kdKmj5YqaFm1PtX1O4ez9o
	Kbnl9uapsHep7iJM8xqLzt+1qz3C+ZxWbdbXOQycZn26Nq6UW2/653LHfpHZViZBpc4RXYQ1JDR
	y7ZL0/jzOnMz6VBni2URSKs/KwIKAKzefQt6KNjJzTJ7VsPh5+mAD8Nr0eUnRiTthkVZU+zE=
X-Received: by 2002:a17:90b:4a51:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38f295145c9mr8809225a91.16.1785166031485;
        Mon, 27 Jul 2026 08:27:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6412ba8csm1894a91.7.2026.07.27.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:11 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:25:34 -0700
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
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 5/7] phonet: pep: convert getsockopt to
 sockopt_t
Message-ID: <amd4ZOz51Y-ttEBX@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-5-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-getsockopt_phase4-v3-5-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, splitting pep_getsockopt() into a
> do_pep_getsockopt() helper that takes a sockopt_t.
> 
> The thin pep_getsockopt() wrapper keeps its __user signature for now:
> it builds a user-backed sockopt_t with sockopt_init_user(), calls the
> helper, and writes the returned length back to optlen. The helper uses
> copy_to_iter() instead of copy_to_user(). No functional change.
> 
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
