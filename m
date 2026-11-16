Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839854;
	b=JJbdyMxcubaBMiQb8EpJdys2GnJtWvwiAG/JkFfCY+GNMS91Ueyl5lvXZ5zi705CetiO
	 4Cw9Bl12o66BEUEvRLikxSDrIo1d5zyFoMoRaHO3+vGPWdFc1vpYhNfSZOAKyTyUd/Afa
	 x5cztMQz26441QhsyOPtBF0Jdmj2EqlWCZ5DP3rBbxahjOBnmxNBFknYFJqzcnQ+IFi9a
	 TlPK167i920jK+GEm51c2h/KMsxcLK1NoBgu3l8EKK53UsOtQTtLxFNqjMBeM9uQVKdd1
	 pfw9hZjKPUqqfIr3um/zYO8vGTR8Izx+pylf4XtlJgmJp4G55Asi4KD79CZEh8zZ7SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839854;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=mJeLQgSQR6c585+OnRTLrz3aLLmsqMPrzGqWlEQ9tMU=;
	b=DzOVySiGWgss8xzilXoB2zbN+uIAHCevsYnud9ao7o7XhzsjZpkyz1G94Pg2gENAK35T
	 cYsKCSDvBkyaRC++JIhzZ+uBcaNO0E1rNJC8U0OWXdQB2LMksS6kEXVjhdRl+v8NHA/uF
	 lLjpQpBoFql+MOV/lpBiq/k4g7wESq6kus5e1VE/J+9SH8IIO1R+xfB/DhPKD/Rysj8fQ
	 ODKO8hJS0iYI9dCIFjoSAILH70s/C3sVL0O0heZrjuNFoMqTyKvBjIxZXKxJQqa3GhCDf
	 zZD9AdfZONpxixHbqP3aiPMAfCyVokeQEU+OgQS54YqwcyxzrhfKy7lmBspG38r8BEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kdPYqeFZ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDF606A881;
	Mon, 16 Nov 2026 14:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23FDF606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kdPYqeFZ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A55361A1605;
	Mon, 16 Nov 2026 14:37:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7157A6023F;
	Mon, 16 Nov 2026 14:37:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 478D611BC0BA0;
	Mon, 16 Nov 2026 15:37:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794839849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mJeLQgSQR6c585+OnRTLrz3aLLmsqMPrzGqWlEQ9tMU=;
	b=kdPYqeFZxICkUypT+YwqNpM0KDvu1zvvTu+50gtmxz4duKX6XyKrYBlAFeK7ZG9P1HlhKo
	ep/qBBo/MqUXgWAJEVr/FeU/Gyb7bekwaj7zRsZjMKbZBSILKKQJrUvGKwnnL24lxd8Wr8
	SYy4591p56rBsSToCPEMsAA2i5q18/b6Ep1FlRzPXA5MMjJgQRuLyxKH/ze5KJ13jZApVO
	YnT6CjG4UPV/sAuWr8uaSBF9NeA/LduzIe4zVebqP+oBiUzmKxZeNnwvn0JCulzLv6bczf
	MYfWqL/wqRU6XPtuEtai5IJzAS4mtIocYRp/vwMlwKh3n7UL2+Wlz1RgFt35uA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kalpesh Solanki <skalpesh942@gmail.com>,  alex.aring@gmail.com,
  stefan@datenfreihafen.org,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
  stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before
 dereference
In-Reply-To: <776e6791-2677-4bd1-ac00-4eef07d5a4a6@lunn.ch> (Andrew Lunn's
	message of "Sun, 1 Nov 2026 20:43:29 +0100")
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
	<776e6791-2677-4bd1-ac00-4eef07d5a4a6@lunn.ch>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 16 Nov 2026 15:37:23 +0100
Message-ID: <878q2ssuzg.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 01/11/2026 at 20:43:29 +01, Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Nov 01, 2026 at 02:52:19PM +0530, Kalpesh Solanki wrote:
>> A virtual network device (such as a TUN interface) can have its link
>> type set to ARPHRD_IEEE802154 via ioctl(tun_fd, TUNSETLINK,
>> ARPHRD_IEEE802154). However, such devices do not have an IEEE 802.15.4
>> private context allocated (dev->ieee802154_ptr is NULL) and do not
>> register MAC operations (dev->ml_priv / ieee802154_mlme_ops(dev) is NULL=
).
>
>> Fix this by ensuring dev->ieee802154_ptr and ieee802154_mlme_ops(dev)
>> are non-NULL before proceeding in ieee802154_nl_get_dev(),
>> ieee802154_dump_iface(), and ieee802154_llsec_dump_table().
>
> Did you consider the other fix? Is there a use case for setting a TUN
> interface to ARPHRD_IEEE802154? If not, maybe return EOPNOTSUPP, or
> EINVAL?

Sorry for the delay, I was away for two weeks, but I definitely agree
that I (we?) never intended to add tun support for WPAN devices. I don't
think it really makes sense anyway. So yes, preventing the 802154 "TUN
type" is likely the way to go IMHO.

Thanks,
Miqu=C3=A8l
