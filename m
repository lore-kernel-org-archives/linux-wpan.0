Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032957;
	b=EEcwZXKKsQN6wvi2AMYEwHZCY+UTHNvUQxBD762jOGkvpnkoCCfaj14u/44dTnbMI3eS
	 PsAlzwy14AYtZrBmjpeqVwr3xHuFP0GrHxs4WJyoKjtA4sVYL9L9fIjO54GjHwutvXOJg
	 1SbWytMlbSgYKqdhlgqgSWLDQD6LLltMzJEMDJQ8f+hfMQc1kPgqZASqyK4rvujuLAEkC
	 l9ugeVPcgAtOWcWwMsZ1YLw8Fuyt+zECcaTR7lXm1MvWYi9DDKIOX1w4EMMfD7sUv5YMe
	 govfAkcbL7iSWF86pmetUFPB+0krcDll8oKjiwHGnWwtZfQtE3FM6y8S+h19UBmahdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fMtnBu3iCFV4jSkaCb7AX9yL/4T5RVnlRz0UlmFCWdU=;
	b=hY6lJCAf5lZ3NT4LojvWyfP5HeCzLCT/SM/CV+pZvZwdW9vC0GXYSSNApCB6Ux1V7M/i
	 w69kuUL3PAyUYlrD+H+kPirIPkhMMLRbdrpYS/w3P0t/CMW4b5S05ch0IHAiDXXZgi595
	 uQJvqTKNRshBsnebyighIvp6E0J7sbk1sxyisGIXARRgszu4CZMjJeQD6yUH4S+tdZ/f1
	 any/TLR0zR+58E+fZB/6iPCaVEgSeFWwpnFgaL2TszC3RTkNxoslPnTrDfC0vcYeYLggE
	 mHaMAT8xn8zSvmsUyE7ZNmLn31uGF72sLO58wkid2+4rTljQVzqwEx3Jncc1//mSdzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSVoa1cX;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7C606A326
	for <linux-wpan@vger.kernel.org>; Sat,  7 Nov 2026 06:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D7C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSVoa1cX
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b2513decc3so775701c88.1
        for <linux-wpan@vger.kernel.org>; Fri, 06 Nov 2026 22:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032956; x=1794637756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMtnBu3iCFV4jSkaCb7AX9yL/4T5RVnlRz0UlmFCWdU=;
        b=DSVoa1cXqvrAH83f4WObwyl4J3m3E83GNS1XzmhGgssIOExNh+4oFbdYhMuhCnuZ3l
         9oiwxEN5AYYTmTqCtjaZEQdLB8MHAl6y0yNsFkGrXp8ukRsJ+xiTQcJKmJSKVeex/aGG
         IDwxDtebUJOYUdPJ3anGg6XzgYLTTXRZh6iXO4NKEye+Vj40vi9nvgt7Yx+UKTCn2XAg
         NEgnOyWPCvdZHBHPdAUSZAm+YG1UmIDa3f1TpFOY2srRBX8+bRJDh+MoFQyKQkLsiX5w
         pHFFuE78TGveuOY//0RVuJEziYtuuljbaJU50M0rkBHBdJYptHvEh9KwaLR3i46bugU/
         oYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032956; x=1794637756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMtnBu3iCFV4jSkaCb7AX9yL/4T5RVnlRz0UlmFCWdU=;
        b=q104nMagBc6osv0azy+OObSjadwLxogNKhtn5JgEZKKtIkoX9ezEZUXKToNJHOeN26
         TZ2vxX+Db6cRg1zHUBceiFCiccNbWGoXtSN5j0w/1AVMZ90WD7vxxlOpP7XA6iHQ8iWL
         DYY1R/NFUZePL2bUKBzaZ9v29en5TIFrqObypCM8/tnOOBAo6lyHSAJ79XFPjwrbqGSU
         tpxVxl+kjdVjZPaDbtdM91DX4v8NdXwObiJt5//bhBD38a2/14R8CuhJ/fGMAYs/teW6
         1MnGBrfLJYENMFC/cnxnW3/bUvQXc4HtSNhcjmW/UmPvxVYw+6AiN2V8Gc7z7sRQWSbc
         behg==
X-Forwarded-Encrypted: i=1; AKwUvBxtrzZuJ+PJX6/xRTWKXNcCFEJHWmlBADkV1vCzWJW9hGXJAmJAf5KQrB9Y7f2LllXtxp0OSGjDxr0e@vger.kernel.org
X-Gm-Message-State: APuU4Z/x4ufUa6IOKnMDaZZ2upuh5FIPxkw+FRtwzjk2dDchZWC10j9c
	HnhL2ICqDcUWhxGg8UnPVX6EW5VF7/ZlJojcOJyK/9SDX8TR30tzCqvK
X-Gm-Gg: AYBFou0BvmtWIsEVVq5bg69Iw6HaoxiQ6VvDzrK6+AtZFRlo/SEF7A8PB3mouexnGhF
	X1/UI5eucg4y8Fg62u5GH4CBL2I2b+/m/u8uAhOKkDMZOMLs5YcnCtenQ3Z+9i+0L++VcUg4GJU
	ujNaxJafxArN31S0a40k4rreZrYYX/J8GXc47/G0gm2JJ1biSnAGcXTCynvvnu3csR9o47CvBfq
	JrHm+eBn6Ye+GqfU4dupug1QkM+ILYc0wGBXktApYW5r9tdJqSEYWVM5ZfXXhK6FO2i9geHvleY
	qPucvNW5LPzS9cKvpat8dXpE16a6KUzKBvMd00eGoXxLEWwzjGR8hDS99EZUZq3prcRE6U/xta9
	YuPfu2UucVcNKVnn134/FxwFYgXcyb843w7DdvGwjA3uG688NkotKZoWx8tdRni1ESNrPlaqdsa
	q3h9fHwfmMLU0EPKfrLSyPxu4WXV6NIflzCK1O+ALmJao5ZaT+dkhUA/r8SrB2tG2gV8NtvxPts
	FsXMuJVNCU5ax4zMhmMm9QvjRVZre5kZSNZeGQU8pXG/WCXC90Z0EwpZAhLT4sISQyaQKbxdyVf
	ii2c3Ar6vEXJbYBY47xcmn9dCSS/XaruxMhmWOmocRx9feUIJlzHd0ZZwD0=
X-Received: by 2002:a05:7022:7e07:b0:18d:96e8:b913 with SMTP id a92af1059eb24-1b25d38ef3emr7391109c88.47.1794032955809;
        Fri, 06 Nov 2026 22:29:15 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b269316725sm4004414c88.16.2026.11.06.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:29:15 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemb@google.com
Cc: Kalpesh Solanki <skalpesh942@gmail.com>,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via TUNSETLINK
Date: Sat,  7 Nov 2026 11:57:55 +0530
Message-ID: <20261107062755.23145-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

On Sat, Nov 07, 2026 at 01:51, Willem de Bruijn wrote:
> One exception is if this has never worked. If this was a NULL ptr
> exception from the start, then clearly no userspace can depend on it.

Right, this has never worked.

TUN devices only have tun_netdev_ops and never allocate dev->ieee802154_ptr
or register with wpan_phy. Setting ARPHRD_IEEE802154 via TUNSETLINK was only
handled in tun_get_addr_len() to set addr_len, but any actual use (like
dumping interfaces, llsec keys, or opening an IEEE 802.15.4 socket) immediately
triggers a NULL pointer dereference. Real virtual wpan devices are created
with mac802154_hwsim. So blocking it won't break any working userspace setup.

> Apparently a similar issue affects ARPHRD_6LOWPAN.

Yes, good catch. Setting ARPHRD_6LOWPAN has the same issue: lowpan_dev(dev)
assumes netdev_priv(dev) is struct lowpan_dev, but on TUN it's struct
tun_struct. On events like NETDEV_DOWN, lowpan_device_event() writes to
lowpan_dev(dev)->ctx.table flags, which corrupts tun's private memory.

Should I block ARPHRD_6LOWPAN in the same patch, or would you prefer that
in a separate fix?

> If blocking this proves safe, prefer as little unrelated code churn as
> possible.

Understood. I'll drop the USHRT_MAX check and avoid touching tun_get_addr_len
or the include header in v3, keeping the patch strictly to checking the
rejected types in TUNSETLINK.

Thanks,
Kalpesh
