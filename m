Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61BE42314D
	for <linux-wpan@vger.kernel.org>; Fri,  1 May 2026 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666172; cv=none; b=cP093bOdxJWcFXchJ/qKEBh2cV2w8XHV2K73yTuSYIcBEGQuvHP8s2unQZmfiLeMUUl+pIrfxN1/ikYGyyXlmSZ95lP/WagPnYPGDZY5PvHUXU0vPp2Z88r9vRL5urGneenlzTV/Bt4k0fKsy8Jlw9cGoZIOfRvmElkPKHvp9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666172; c=relaxed/simple;
	bh=8urvMXkl24OSZEB0wpWz9ry6TWKjiahjJExaXhP1+c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9R3dyxVgSvPtWFDEFc8BEFUosJDvlR9e+isTSkxZp6n2+/DnxqrVX5Bg+1Nd78qCUabW79QQ88YOpVplhuZu2udvaGBNFGANLK3n96gOc+leH6z++OlEIRatdL3vNxoeEBFtL/iVn4jNsfajtOCqWkiQWPhQz7bw+T6Y7zV5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnDC7fr4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnDC7fr4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so2801422a91.1
        for <linux-wpan@vger.kernel.org>; Fri, 01 May 2026 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777666169; x=1778270969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9efDW0M+5+xCAVk/QjLEYc7GQc94XnH8yiFV36Yucj0=;
        b=GnDC7fr4mCgs3WLus0hMXkXLcgMjItLxAOBAxo8KSQhgZ7n1aHBDiShJPfzyXe4GeH
         imv/FQi/U1In7yp9WDCQNP89HRi4XJX27q+bwjiMHKewHgYZNEmWWnmcFVicwmFsKZ8I
         iCbfuNToL9tQB/Rbvftwn9W0OgTgHMX/mjwhJQ2LHzMBRDCJF5iRDqbinKCFcFTDsrz4
         3F9x417kEV3NaSQEPx8TF1qePG0wxs6uoNwudx+P1IfOcjdZZ8YwiRgnw5wbM3lpltxA
         Zvn8lp/HFxlBpZNsxFjLpr2J3m1DMCq7p95J2l/1IJLHg8qD9T4ka4OgUtKp+RAOJxEy
         RT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777666169; x=1778270969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9efDW0M+5+xCAVk/QjLEYc7GQc94XnH8yiFV36Yucj0=;
        b=Qm+Vvlk1QuTt3W61sK5S4z9WzozGsY4Ods4y304AdYd/vgakVit41xLhOhjJDQhzRa
         FmyCehpQ6Le/i95kXQEL0ae0MjkZbhgcdgcZ9YjnAKQvc4UofUWHqAFdN+fQ2Gi3irHA
         khfalvZYccdt6robaW0B81TbFVjDl855EGXVE7/sUS0fGUddHRoNeomj+1TXZ1AMdUrs
         7GuZ/7pzJgSG9a3Nlc79ppdNUp5Nbiy7/4nX375nP65tOAQgDmh9mZPLI1vlFDANsVY7
         F7jErcT7W8z76AaISTHQmQs7oFeXIn/nqIbb87+R/VHIrU9ZW6vTS3JsUQfIUnNmfR3k
         ASSg==
X-Forwarded-Encrypted: i=1; AFNElJ+vgisZ7BVV5JAIiYYWibTgOxvRqYjIrmJccJ6c+0fuExRjFj+H7kfnMnNwsp43ymTpq7/insUQHo/M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+54IhYE9fj7CasbEvCEG8draMTdNF/eOxS6TXbgwJBZWYAcKP
	qmlIiMUjvInui+ykF5kF3rI1ZzBJYD3w5lmag6CTj3SC4tSFY3pCqOWb
X-Gm-Gg: AeBDietA6AFEeMLYbySTmYgwl4VC7PPaGj0H3pDna5QLC0XgeIbvdncsT9Xv9DWgZrr
	Ubkili8xjtkYOLKy2fcoYn2iZTVCQ0D1ONNetnQmH8DwCRI0TO5e+pSzsr8pRIQPw0TjXwWnohN
	G8qHks07CWOrpje51eEU4rTycKZVDyJdN7ynSaOX3nXYLzAxItiy74mmwJIHA3Dl3K4VAxq0Bsx
	nBM4rxppe5WSucfreUf0wDem3BFUzAHpK/zJjiBSY/yynV9LhJD+6HaPCrGJncn988BoTsjjSXX
	EjJqFCZPpDm4e5tydodBCp4aTsO5rQveJj2o9G6NZjv7sSrR0zIvLxtwOJJlq3SJYF13o6zsAfn
	+oFM+T3NsgJhJiOVWErs/suIf0IUI1SA4NnUOBdZCapGepctAq6GTBw6krOUjUX3kX2582p3I2U
	d8VEL2LRndLq74WD5uLYVzjS4NV14iL2s6CueQ4kIRFuUafuoY8gqbGeBgq8DnWua6+tc91Lh4
X-Received: by 2002:a17:90a:d444:b0:364:74c1:53b7 with SMTP id 98e67ed59e1d1-3650cda5d5dmr628144a91.2.1777666168755;
        Fri, 01 May 2026 13:09:28 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2ac19sm8253866a91.3.2026.05.01.13.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:09:28 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: stefan@datenfreihafen.org,
	alex.aring@gmail.com
Cc: miquel.raynal@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Sat,  2 May 2026 01:38:03 +0530
Message-Id: <20260501200803.3371428-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260421073259.12345-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260421073259.12345-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stefan, Alex,

Friendly ping on the patch below.  It still applies cleanly to net/master
as of today (verified against torvalds/master), and Miquèl provided
Reviewed-by on Apr 21.

If you would prefer this split into two patches per Markus's suggestion
(one for the leak fix with Fixes:/Cc: stable, one for the misleading
error-string cleanup), please let me know and I will resend as a v2
series.

Thanks,
Shitalkumar
