Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422558;
	b=BUDOvzsCytzyohQo7OELry7xYCLZoRGnB9PtECeQ2sfbz9c9Fx8ZZ5e/q+P/7ulioz0g
	 nkdcyZ2Lxln5eKp1uGXaqUq7VQlrrcMec7G7rHBSJDirWg8N/Z6XoV2D0snwjVB803cV2
	 GfxXj3xQrg00LcYqa4uu9NhDOia6frgVLA7R5ZtUSD4y9LIBmbQYjNi1G/y4HjBCGPhbF
	 huzLEw00hlPW7cuoQR02hEZP/Q1K4ABuJne1npJFznf5qnHHA89K/J8qaGIt6Q3/lJ2Uo
	 ZbcMl9xOMvzsU9aCvPkLFdm3kewXvaqLliV3DmXzVLC8PyHg9VjWn4pohb9jcIfPwVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ddB4FacqIQ3q4kAqUUsX/lS6szbTGftArKoCUpP16Is=;
	b=G8jIe9KBo0uZXRoeBIYYJ9Mx1sMe4O/cY1pKfN0edV4wEnx6ltuHvRUVYl7WJq3FTb/H
	 gZcOnbcVpm2+TnuL8kiswafJ0WlwVxeBxZAuj3UGt0i6xRzyyasIw819O24fDr8lBkey/
	 /nOGaETTrAkQX7bnqZqaqIkm9FFIji1FN/PsIc4sd8IqRo/EuogARxnRpK4C02f/TuwxF
	 D4Ib/6B5A0BBfRD/SLm0oXmVY36+POnzeMHQ2yOv+H2ROJ0OiJudf/Htn2cgi012ht+rx
	 hH8zScyynFFcu7ZS6xXM7zxvY3GR7QdYIGJ9jhYQUMdGN6AxMyvXMlUVnxbQHLk8QpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQX0gmjX;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408C608607D
	for <linux-wpan@vger.kernel.org>; Mon, 19 Oct 2026 15:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6408C608607D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQX0gmjX
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-17bc533fda3so2485922c88.1
        for <linux-wpan@vger.kernel.org>; Mon, 19 Oct 2026 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792422557; x=1793027357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddB4FacqIQ3q4kAqUUsX/lS6szbTGftArKoCUpP16Is=;
        b=PQX0gmjXqloOScR31IyWgcireQx9fQT73X3Zpe08XKJbs8GqVMJ4KNbjN8+L60KuXS
         5Vk10qFz9nXu8jDZwILHl0ivMfQSmgPWmV+ssVfeRAfCsvf6J6Jkoq6OHAfEpBSUCAgU
         V45rL/7HO/YKrsqIyxvZwkaJ2Meo12GUZ5zSuKBZ0eSiuBjPxy4v/VSaxclARSLcXbxU
         deApW+wAePATk/kvUdSUJYGKE/9RI9ssbaDtNOaFOKM7Lc54fLOx351BxdQT7Z3/rW6f
         JCzWV9sfBRW7hpFcyPi330cllnO7OxWGT8RB7z3YI7SknpDdFHJk3AcJyaZlZdP+AprG
         PD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422557; x=1793027357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddB4FacqIQ3q4kAqUUsX/lS6szbTGftArKoCUpP16Is=;
        b=kGYOsiESv248L9DPeiSU045hdLO/h0k/rX4NIKG+7q2dda1ID1GK3FVcWc+CkB+sN6
         LEjRhbtDFn1KXJxVMowiRm/pguq8lHTpjlIa7rFWGsdWVLwQsbl3pHkUKRxiJE3eB8Ly
         nOl3UfUHKMkS7hWmsGmHaZyximnZ354XOchuTDHJKhKSOe+SB2cA5xQejac6m/gPq4oo
         seMZG2fXEwsVvXtS8jTSd8JQRq4tb3/V1l3f8D6TrXIJyZS6MlUCsXKEiqKye5Ql8f02
         LLgxLr6oNcsJXqeE6brx8BbPe9RK7aic/Oy/ZNyAx5C+SbIHc7+LHqzELofgWmNX1dox
         M3nA==
X-Forwarded-Encrypted: i=1; AKwUvBzBb5oP2bhWiWnRTO3T0YdoqK8Mg9UbkqrXmMdSKxd/nFkrGmnmsNNm97rPrGkRdaJnmNYxrHm9xpqX@vger.kernel.org
X-Gm-Message-State: AFq9FYJn57O5AHpyhJxWdQXouS5O3m9DmIWxCNis00dGr6BJagwtA/5k
	91H/z6A9UuwaaARSioQ/IyaPzN/wxGyfp7P5jc/4l5lvt2WxShr3J9rd
X-Gm-Gg: AYBFou0vHvPGYBZ1TXXT3uLGQ2pVGWLewtLgIX0gHWPBzMUbPHG1BvOOHXn3chjCaBV
	3wTekfvoSJWT/3gdhmfNw0JHL2403D6YNMARs1soPxJwTdHkmx74KCQ9MUQUbT9XjGPds+Mzl0i
	i10arW1zAGcJJ0SbdTM0J8vGBk5axKT2LlPdx6J18n7U1JMQybt44jVrSJ+FW434TjI84iJD4F/
	0nBjKDGYqlmKqk/MuEsxF/md2fOi6Zj32AXwPYfgVXecUPGmOGMKclHSPB6TCrtVYX+rI0BN3+F
	AkDcszyAlHFT09cjPMSbkX/LedhLWwpqY99YRQh1/KtWSGC+TRLN66fBjCFikH5u2HsM/QqAuVm
	DoA/d/GnFbGz0l6geMlFXJSrfj9S82qLPHMgBPJudUp6voDfgsAt7iseJZynH0UCFwQh65qK3fV
	Flb2JpenOv4PjgjfJ1fziFLhdkK14ttxMWfChnGvJeWXtB7hbIClveFvstxXbj7OYg3gvnMirQM
	kunKby48URq47yPCb/37MM=
X-Received: by 2002:a05:7300:ea8e:b0:360:c266:cdd8 with SMTP id 5a478bee46e88-361a1f5679amr10624281eec.24.1792422557361;
        Mon, 19 Oct 2026 08:09:17 -0700 (PDT)
Received: from CHANDRUS-NITRO.localdomain ([106.200.8.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm34680599eec.7.2026.10.19.08.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:09:17 -0700 (PDT)
From: Chandru Gopi <chandru.gopi.dev@gmail.com>
To: maoyixie.tju@gmail.com
Cc: alex.aring@gmail.com,
	linux-wpan@vger.kernel.org,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	stefan@datenfreihafen.org
Subject: Re: nl802154: GET_WPAN_PHY dump resolves NL802154_ATTR_IFINDEX in init_net
Date: Mon, 19 Oct 2026 15:13:22 +0000
Message-ID: <20261019151322.8175-1-chandru.gopi.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920165057.3753458-1-maoyixie.tju@gmail.com>
References: <20260920165057.3753458-1-maoyixie.tju@gmail.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 00:50:57 +0800, Maoyi Xie wrote:
> Does this look like a real bug? If it does, I am happy to send a patch,
> or to leave the fix to you.

Yes, I can reproduce it on v7.3-rc7 (58161ead29e5, Oct 16 2026) in
x86_64 QEMU with two mac802154_hwsim radios. The lookup at
net/ieee802154/nl802154.c:584 is unchanged, and I did not see a fix on
the list or in mainline as of today.

Setup: wpan0 on phy0 and wpan1 on phy1, both in init_net. phy1 is moved
into a fresh netns with "iwpan phy phy1 set netns <pid>". From inside
that netns I send NL802154_CMD_GET_WPAN_PHY dumps:

                                          before        after
  no ifindex filter                       1 phy         1 phy
  ifindex of wpan1 (in this netns)        ENODEV        1 phy
  ifindex of wpan0 (only in init_net)     empty dump    ENODEV

"after" is with __dev_get_by_index(&init_net, ifidx) replaced by
__dev_get_by_index(sock_net(skb->sk), ifidx), as you suggested. Both
cases now return what you described, and the init_net baseline is
unchanged. No warnings were printed during the netns move.

I used a short static C program with raw generic netlink for this. I
am happy to turn it into a hwsim-based selftest, and can put it
wherever you think it belongs.

Are you still planning to send the fix? I can send it, with you as
Reported-by, or send the selftest alongside yours, whichever you
prefer.

Thanks,
Chandru
