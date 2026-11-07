Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064118;
	b=fcAiIUbSwtZeg/HSWIfQLrUCIGEikTIpYHwvp/hgyM11GNREZMpZtZUw8hIAo9IistIK
	 qaJbrldiLMpab4VSTOB6vEokb/xoH3kdQsmrcivnc7mMp2OiP2hHEcykZUOCCR3OVrk6y
	 58gICsh6LPurNDDl6iZMzDJHL4bXhgf84i4IDtUGvUSQdhUfA4Z+DDGLJhsV6BI+g5h8G
	 tRhfnn6YyNEygpN4NxOmaoqEaf/CGkyF2wr0KkKPT8re0Jb2CkPE2rknWfxeYCkAf+j5O
	 xL88Krsd5FjeOdvYB9iibLf1v/DHJwy/7G8gBetJWeDLNVPn17eCXXXDyFEy6wMcokQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ALGSenX0zs2BVHF/84nUUmepv/GDcgnI5RNZWHPQC+I=;
	b=YFNc6FQgLKVJwfkAHMZjuIsHV63mIXUP4jlhJZwrRkcBmb/gKBn+EWFWdknPzIdrtYw4
	 iDNX282u1MVyuHmWcCLMxHQa5rMd8MrZU/8DHuRaNTFssmm1EBXQRF3L1+v0ESvlImp5r
	 FJajn4SA4/AknkXXfeXe/arxljcUN11a5ty12FA+/v29IxHN3+U+T96vTS7HHD0/4S9VA
	 fuFWOMfVBGMtzjPeCCGJjMURQgiqah91Hq2AXmSKKP9CmgnBnGkK0eBEEEjeB01pPNq7j
	 Qe77px0vD5xRGU6hvb5vhlaTlxlWmpv7q+RkPytqih29uOQ6v7iRrqkM0dVZp37tuog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JV1vknhq;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB96606D83B
	for <linux-wpan@vger.kernel.org>; Sat,  7 Nov 2026 15:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB96606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JV1vknhq
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so554814e0c.0
        for <linux-wpan@vger.kernel.org>; Sat, 07 Nov 2026 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794064117; x=1794668917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ALGSenX0zs2BVHF/84nUUmepv/GDcgnI5RNZWHPQC+I=;
        b=JV1vknhqyz68CXblk7gJJEBC30Y31srYk2XDMjYnwMH9498cfA1iexxosTCnNbEZZy
         hzmlQi9mS5eh/uB/LIKf9M6obAQZdSM9XSCkm0rHeZQVfGcTtyCGtGEpK9ttqbUjLZUb
         /iFAZ8BTYWoDKxySIgPu744IUaOwOEU630Wl33rM+O6wO9sBanuUcjen+4gt5/FjsxB+
         E1Ag4O4IGPq6fLw8N+0LKwHXjl6mLo0CuSwBz5Gv7sEIWV6B7pTfMcr4E8ObuxucWql4
         B7dF6RojE7bezcandIg4VziQxbb47WzVHiAjAG+j0V+kVmSuTGsfwhdAXKwBNySOv3ZK
         hxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794064117; x=1794668917;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALGSenX0zs2BVHF/84nUUmepv/GDcgnI5RNZWHPQC+I=;
        b=DYolVEJsxBNUNl26oRw3/LDOP0A23fTwFlLnxnhLdx0HLg+0Nwg/jzj0NH1NZBrBuu
         GXXUlSovuxB1ZALZjIB2yJCzVN7ctQtL8b54iPGVVSkvIdZVg4HDkdulbeE8C+d1Mktg
         JrUI+gCygCXPQAS62jTXwDWJk5/MjiuceWqG89OhdCqMUEUw38OA8d2W0FTKksD2HqHW
         Cc345cBF4Vug1949tWPPBHQYo/yE5vZd7TREZ1m7qfBU4Q+mkPiK/+yAwZyjXGJMWAOH
         fyV2DW77M/ahBsw69l/DqwT5O9m8E8L7CWd+a8vwkMfDBH21Ar7hTEJstL3uUYdjYIDA
         d/2A==
X-Forwarded-Encrypted: i=1; AL+hErE2r6X1JUKHoM3Fw4x/VH3nt1Qj1t5DnORu1w7fNoVQ60SpgzIm7jTJGYjGqKJweVT++bnGHsp5GcMX@vger.kernel.org
X-Gm-Message-State: APuU4Z96lA8hEV3mAsDNB26tXwkrWVRnqGTx0MgupJ+MXDsI8ItHAubx
	X4FXzHV3sjUG4Neq1oTswz2Vpd6wMR6ci46GXz0uUMhVRtJDNFGGrgVK
X-Gm-Gg: AYBFou0zvhGsTmGIzkROKPZljXtY3+cZbBH0H0+aGR/q5dwZauJ5kCSWIeNU2HXepbI
	LDVkTN4/upZMcwnOcN+YJGR1eHp2tZv4FjFoMlmmoivnVxVeK4KsQCpwxz83AilAozwqU43N3Hg
	15ZcSbvzSYlzj7MjbP4Sq3YVuDdgYfa5F9J6ZJ/V7W84OmRBm4e5CUkpUJ0lR0sFTh0y8a3iudv
	jypN1X/g12bMj991qtLrBQjZILuG1tJAtjzHRoTysBHDudw0Pu0uJdNx9nLiH1SPt1m8dYNxHSh
	KXDefWVvqCW3RiyQg+MD5OD5nIVVljcYgYyjBBYB1rqpHSxlqeqqpFwMt2C0C8WNSOagMD/vBQo
	kfwlgLXrj6ydXjtj/Qfl7Z5yehZUiqDvjPBAb1eqXvD7d5yzOq5mNtlQBVynodyYSz5Hw5aVLys
	1WjtPQuSKUiXVKM0Fnk8ohBEhoMQq47CQwb8PvLIthkZ/JTfW5lrbMJViVjk2f59ebHTGyYoNY2
	ZX6z3kkgYbOa5KB/Cz9FlTfFGMk4CJxo1yO6teiJT3C27nUaNCZ3tixjIvdLEBOStpVNQpo5hNc
	IuX1UzEgU6rNAVUIklYWUhZABqpiVFBxNvmimr0SwDWBnQZjtt5TaFGZLghd8tV5ZVvOApia/eN
	umRPCQ4bZDbz0t2SJt1TqpJWl/RbPUeuefZ4HpVLG+CMDq6RY17mtmdDHU3OPv2ExXkSRuz4=
X-Received: by 2002:a05:6122:6e0f:b0:5ea:cb6c:6513 with SMTP id 71dfb90a1353d-5ecd1af4864mr502091e0c.1.1794064117333;
        Sat, 07 Nov 2026 07:08:37 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ccb58sm3801606e0c.9.2026.11.07.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:08:36 -0800 (PST)
Date: Sat, 07 Nov 2026 10:08:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kalpesh Solanki <skalpesh942@gmail.com>, 
 willemb@google.com
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
Message-ID: <willemdebruijn.kernel.1e7cfcaee3e82@gmail.com>
In-Reply-To: <20261107062755.23145-1-skalpesh942@gmail.com>
References: <20261107062755.23145-1-skalpesh942@gmail.com>
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via
 TUNSETLINK
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kalpesh Solanki wrote:
> On Sat, Nov 07, 2026 at 01:51, Willem de Bruijn wrote:
> > One exception is if this has never worked. If this was a NULL ptr
> > exception from the start, then clearly no userspace can depend on it.
> 
> Right, this has never worked.

In that case, the fewer these weird exceptions, the better.
+1 on explicitly failing this, thanks.

> TUN devices only have tun_netdev_ops and never allocate dev->ieee802154_ptr
> or register with wpan_phy. Setting ARPHRD_IEEE802154 via TUNSETLINK was only
> handled in tun_get_addr_len() to set addr_len, but any actual use (like
> dumping interfaces, llsec keys, or opening an IEEE 802.15.4 socket) immediately
> triggers a NULL pointer dereference. Real virtual wpan devices are created
> with mac802154_hwsim. So blocking it won't break any working userspace setup.
> 
> > Apparently a similar issue affects ARPHRD_6LOWPAN.
> 
> Yes, good catch. Setting ARPHRD_6LOWPAN has the same issue: lowpan_dev(dev)
> assumes netdev_priv(dev) is struct lowpan_dev, but on TUN it's struct
> tun_struct. On events like NETDEV_DOWN, lowpan_device_event() writes to
> lowpan_dev(dev)->ctx.table flags, which corrupts tun's private memory.
> 
> Should I block ARPHRD_6LOWPAN in the same patch, or would you prefer that
> in a separate fix?

Depends on the complexity? If you could handle both, that would be
great. Sashiko would probably call out the same thing otherwise, too.
No preference on whether one patch or two from me.

> > If blocking this proves safe, prefer as little unrelated code churn as
> > possible.
> 
> Understood. I'll drop the USHRT_MAX check and avoid touching tun_get_addr_len
> or the include header in v3, keeping the patch strictly to checking the
> rejected types in TUNSETLINK.

Mostly, try to avoid changing the indentation of that otherwise untouched
basic block.

> Thanks,
> Kalpesh


