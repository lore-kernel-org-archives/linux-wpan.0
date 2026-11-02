Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587695;
	b=prYfPYqXTN+UPzwtk0HSp682FoEaY0yr1H9QBszagoytNCFUDGFz09XLPvFYiOVaxJeg
	 bblrAHt4yGcJ1Y/Tp8hv5ofkw0M3HBysZX8s/IQXKKoj22r/6Q7apn0f9YLSus9VEjWJK
	 h3XZWK4t7yiysLr0OfBUx2hRRf/ApLNXqgvQd2ILkKc+JMLJCLFL9Sx9SOeX2kybHjxn2
	 p+SDLbK38sIO60cMCrvclKQUzIThjZy1GRdQKiieGgZbPEOsvtsCMdG2A1qbMrleDiUKF
	 xT+tOyaC22w6IWtZc4Oo1KrRHTqMCgTPzR8LA6uVW9z+yeIJvYY1ioQzakH4PxM4J+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
	b=AktcvER7NEYIpF2UvsVDYqNky2AIfgkTwktrVKYAGUL/8Z4jVdWn8PrR5MbJ88VBSook
	 HtkbKUEK3+QoWBWggDFUXdcTDwY9LsQFoRaOJ0zh7xi7MiAJh6wkvsCWpPKhwcdkg9hlN
	 QU8RF75J9QmbJRka29YU7E+QWdRp0LJ2pGAuHY5SDaHF65/kkl82oebkJfHhmmCLBTNDa
	 tZ52V2h1O6jDDeKfO6QBS9NMRmyAKJaQK+CneEq9H0UC3VS/fUdT5MxNxOLGEOJE54x/Z
	 MDuy/7xlKB64Z9tw6rRVMvGtF/FMnrC08Y24PXKGw1yyCijeeASw1an6zI3hoOOGONg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRk3+SWj;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14829606A338
	for <linux-wpan@vger.kernel.org>; Mon,  2 Nov 2026 02:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14829606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRk3+SWj
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15943c9c005so80916c88.1
        for <linux-wpan@vger.kernel.org>; Sun, 01 Nov 2026 18:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793587694; x=1794192494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
        b=XRk3+SWjrmFi47T+BW8eqendwPWmdwpi9KgXy9BnV+dovb2ge7vNhFjLm16xv6o6ux
         vs8KDvC4qWMFoI4VY6oH1k/UK5kSFBNZ8kW0FCRmojleyATVsyt6brflCeE3BaU1JCRA
         eocl1/Qw1fsH5888Sty4t7EL3+OAaWhRKzGUjw4fJTb86AlmQnxXn4S0e1xqRjkKuTRg
         dWgSi767xghB4fE5WjDkgi88GJeS41ivbBGy9PHocuyHpkdgh2NKpK4zko41yfl0IcFP
         SMETV76yFrDufnc7iCLlADKB6DwJvqzOnYCQ78An/4Ev/l+ZU0KoKo+GdWmEsBvuqklf
         /LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793587694; x=1794192494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
        b=loqAjhjjbELEGx83NtoRKZ8ZFagPEPw3CfRYGgLNLQOkSZ7/33cg7TYbOwtJ+IzWIO
         2eDLebad3dhhWx4VE4POsxcsjZ/smySFKCdKRDxdIhYfUo+6m3OUnGfy+cFjUw+r+beR
         xYXGJZGn13FoGtn8dP4JJeV4LBOACt7ss+4qzs5g9Oz/jfY/Oa03JGLwYTrr/MOuKJUR
         nmsqISGsccqCGhbCst+d+wDlgPu3dDmc/Fww8QAIUshisrCFiJ42EwRhNm+Ql97Y1a8h
         ltaPZUY7MbfwTVsi4654eU2mu2OnIxqEHL6zARUTUuI1o/C22yEr//wuchgMrj5nVgpn
         ak1g==
X-Forwarded-Encrypted: i=1; AKwUvBxRI7kg1GpxLClVGZdRkFqjwA1WYnDyzHPQc7o7g3ROJhw3z2yeuwSkF5zn2w9l7ocUbgXtVxrTW6ea@vger.kernel.org
X-Gm-Message-State: AFq9FYKWLE6prlv85KlmvxsJ7+pSexmUE4TTv4x4BL+rdJdkZZkfdd8q
	bei4qjhsN7QtiRbhDzJ3tTGI+Ab/+zT3RR7hoBvbUpJvOd0GTu9Bc+5N
X-Gm-Gg: AYBFou1cmWf4M/4z9UR14bhwjZdrob4eRdO1WPcmSoXcpuxvZq39rD00ezThqDQodjs
	+C0gQ1LLWE5waIiia1s9No01rblm1g73BnvDmEQHVT+EX4HGvTgkPGJ6kzzuxMegV3Dqrg48XbV
	DQy+W4i1intzDBgLMzTzSY/gSinb7MSUzGqo08SJ7M2NnOPPPzZu/aaqTfhnyOGmcrJnsW50ysA
	5AaL8wjEi1Js68IpQ+JwmPSYl7DIkF+alpxeOHGxMJf8utXFS2L59soXeaEAKR4maHlQePsUwXc
	l1EaVOkfBC+U/uoNWW+aKuuJXXQNnoh2BcN2qWxglfgp2yAYoqoB2fXWC80qAcIAFvyJ7gLnFZu
	9hqXg1+PcUYd5QwnHIrZe1FOgVv9d3P1IlE2DutVao1i0bVcEPc2nTTsbc0I/htB0D0zWGMnYuK
	zYGpac8mnd8GVVh8mtC8/8sF5vhwH5a7tlq3qm+2pvGIeRFUPaCgTLTdRnzeBzDuZlIUlhMcB9P
	mO52LIYBkJUvfxDgleXANAHtZghdzXq+xPPPxTIEjUptDjrAS+Wte2KIWiEkRm740FzKgDBmBZ6
	BRpqXpy0ea0IeOSwJdfE34y06UexjoXT4OFq
X-Received: by 2002:a05:701b:4281:20b0:158:1ed2:cb58 with SMTP id a92af1059eb24-1ac5e6f5362mr13936565c88.39.1793587693890;
        Sun, 01 Nov 2026 18:48:13 -0800 (PST)
Received: from xploitoverload ([2406:b400:f11:1bac:4040:640b:8a1:8629])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm29930662c88.0.2026.11.01.18.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:48:11 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: andrew@lunn.ch
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
Date: Mon,  2 Nov 2026 08:17:21 +0530
Message-ID: <20261102024721.28129-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101092219.1278751-1-skalpesh942@gmail.com>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
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

On Mon, Nov 02, 2026 at 01:13:xx +0100, Andrew Lunn wrote:
> Did you consider the other fix? Is there a use case for setting a TUN
> interface to ARPHRD_IEEE802154? If not, maybe return EOPNOTSUPP, or
> EINVAL?
> 
> Andrew

Hi Andrew,

Thanks for reviewing and raising this point!

Regarding whether there is a use case for setting a TUN interface to
ARPHRD_IEEE802154:
In real hardware/subsystem usage, virtual 802.15.4 interfaces are typically
handled via mac802154_hwsim or fakelb (which properly allocate wpan_phy and
dev->ieee802154_ptr), rather than raw TUN. However, tun.c explicitly recognizes
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR in tun_get_addr_len():

	case ARPHRD_IEEE802154:
	case ARPHRD_IEEE802154_MONITOR:
		return IEEE802154_EXTENDED_ADDR_LEN;

which sets the hardware address length to IEEE802154_EXTENDED_ADDR_LEN on
TUNSETLINK for userspace network stacks/simulators (such as IoT testbeds or
custom TAP-based emulators) that expect 802.15.4 addressing.

Regarding fixing this in drivers/net/tun.c vs net/ieee802154/nl-mac.c:
We considered returning -EOPNOTSUPP / -EINVAL in TUNSETLINK, but chose to
guard nl-mac.c for the following reasons:

1. Subsystem robustness / Defense-in-depth:
   ieee802154_llsec_dump_table(), ieee802154_dump_iface(), and
   ieee802154_nl_get_dev() assumed that any netdevice in the namespace
   with dev->type == ARPHRD_IEEE802154 has valid ieee802154_ptr and
   mlme_ops. When that assumption fails, it triggers a NULL dereference
   while holding genl_mutex, leaving the mutex permanently locked and
   deadlocking generic netlink system-wide for unprivileged users.

   Other parts of the ieee802154 subsystem already make this defensive check:
   - net/ieee802154/6lowpan/core.c (lowpan_newlink):
       if (wdev->type != ARPHRD_IEEE802154 || !wdev->ieee802154_ptr)
   - net/ieee802154/socket.c:
       if (dev->type == ARPHRD_IEEE802154 && dev->ieee802154_ptr && ...)

   Guarding nl-mac.c ensures the IEEE 802.15.4 netlink handlers are safe
   regardless of how an ARPHRD_IEEE802154 device was created or modified.

2. Userspace ABI compatibility:
   TUNSETLINK has historically permitted arbitrary link types on down
   interfaces, and explicitly supports ARPHRD_IEEE802154 address lengths.
   Disallowing it in TUNSETLINK might break existing user tools or test
   frameworks that use TAP/TUN with this link type.

That said, if the consensus is that TUNSETLINK should reject
ARPHRD_IEEE802154 (or arbitrary link types that lack driver backend support),
I would be more than happy to submit a follow-up patch for tun.c as well.

Do you think we should reject it in tun.c in addition to guarding nl-mac.c,
or do you prefer restricting TUNSETLINK instead?

Thanks,
Kalpesh
