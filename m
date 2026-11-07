Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072440;
	b=HedzJbhP/ab4RDQNZ7hpdMkM69kUVtxu4X91w860pUAtk332pOeoJSwMlfGFLYhx0aBh
	 bfBMuNeJ68hFknNwlPisVzQKdB4mcCCENm3oEvo+RproKorKIMzI08HvX/EkugrlWU2QS
	 c9W/4lSlu3tW83iS/vErCjvrOD0kyUGdbIcqTnnoQOvcz0jsesUUoI+xf4x/obfS7xYSA
	 rvU1pkhCe8vRCT4S2VNW3xhUpMUFBwbAmzi7HUjjpM7xh80slmpvbOldGsBYAboWPQMZ0
	 jlelqg4jw64o4MwGlGTpu20EHo8kDZNvbeYNMZWUk0OfoN4tQXNoODQQhc/blD69+Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZZwMrztt3of5COKCtSyFNtiXLTIolPtZxVxm9oGuspE=;
	b=uAHQX3UACbgaB647SeV5jvbTeeLfWJHgJGOMTAyL5+o0NTemaazvD3W0ylV9Bt1M2vaN
	 GAHAg2MOBir/4ocPJvnhglVtvu4db9cP3IXklCpmwbdKVcBhAe1ptvhXSB+8HtyZEwmq+
	 jtlST3Ax/7Ly+dWLwufqQdGqJ8pCS8NP9VQ5N7fWDB+OiDfQP4X2f8Y0GZj+/2qtO4RXC
	 kTnQnZxQ6/096uofm+Zige3QVxQngyTOHYiP32EEyQK6c05W/3mwJOVB9oPx4f4/Yvg5v
	 fJUQdePdowuyWlPNtMo++zKeUy03OUD3qYheg4olw4vhCmdVdHSUyuZHw/DERi3Bl6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kBRtH//X";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8F606A32C
	for <linux-wpan@vger.kernel.org>; Sat,  7 Nov 2026 17:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA8F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kBRtH//X
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2734293eec.0
        for <linux-wpan@vger.kernel.org>; Sat, 07 Nov 2026 09:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794072439; x=1794677239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZwMrztt3of5COKCtSyFNtiXLTIolPtZxVxm9oGuspE=;
        b=kBRtH//XVichkRikoXz0f3WTHIlITZ1SryQ/0NJaXxcgxJFnQ/kWxd2qN0cvEbrSgL
         vCc28+x19SetD/5AU+3gDnvpS5OHzdWqfuGF9UY7PUv1jH8TI7eChX3qnXl5d9fW16gI
         /0XbrUdOwcKCKgx74Oe+0MSoMHyiNB/WfghnbVXVBNsji+jK4eN85o+MoW6g4r6tNZ9v
         xExwIOsgc7Iw/yN8G4BEZQg3JbyGk5jhCEDiIxkXZgw//mp1v9zKzx/fWSj3iwDNn8jh
         2CKFV3WKhWqCZnbwJINRBuR+TOsiUzP/UeebdcHL1QLw8bAuVb+djeaNLs04FILbPfJ5
         mzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794072439; x=1794677239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZwMrztt3of5COKCtSyFNtiXLTIolPtZxVxm9oGuspE=;
        b=QylNQ4YbuwAD6hSwK+Wf7z9yE4/x6vgtopVKHrcsDkzRdfQd58nZ9250DevmGxoa5b
         7pBQ3i6Ys5uBY4IvkG38ES0EnwjjbvD/Q1KtnAjXEjiLtfgw5zj1PH2Uw+2kmD5EkRYc
         zzWIccH4WfmumvjUhrmgJ1MGJdNALercR9VsJQ/pS7OVcViu9qDeZDBCEE1thyj1J169
         flNTofx0P58LbYkRfnPf67NqUSP/E6575Ia8F82sQuC+v9YwLGNievsOC5Vfdp5gzRR5
         0gm9wZlfUMz9ERk4y43erW8UFDKsQcWvV74NrrEj08i5w+uuo3VCRHAyZBeBOyP0xUv+
         1Gyw==
X-Forwarded-Encrypted: i=1; AKwUvBwToSsj+6a8f5nAu/MmqYN9RuDQvHXSNpJ4Nbw9lI49q524Hngt75LA70nu0XFf+MZMZXyXeBQYRVUp@vger.kernel.org
X-Gm-Message-State: APuU4Z/JXbUgvXoTx9lmiQb1dwRygtl/hwetHotFZwjRsdNtKenzP2//
	QmGQBpTTRmhmCOVHMoh1Sjw9CEk1bjkMrC2gH3jVa/ygvxCDvTuEUZCU
X-Gm-Gg: AYBFou0ZkdnN0OFzx0ymdMGaUkTFJRyEvL6DnC0NR1wK3UgYsGmGe968bsMfp+4EYE0
	Hm0IwFh/NdZSc07Ksk15q8borJjOc0RV1cZfqLKsFGISQzk9NWW/bxP4gaG9IrYiA9cDqP4hRs8
	BHEiEcFl4aPr44Orcqs/4tiKr42lPTi1DqtGWL8d06cIrLSuXJH5/MCpi3bG6e7wn7P1qu8Esbj
	6IYnpz77gI2yZPIo+UCnKPffTU1dXzFbEI/7rkybjDtp1NX2zF8j3Ji+IXLzM4Ubjc7dPTUR10N
	HuLZdB1cSOfLloo+9JyKuab0RGblguNcda4blDduYgm0LOe8AT9M4Z36n1RHTXV0nefs4PF4UXh
	24SoQEsrPmFwg6jbeDqBubkQLwnW83WH/VSvSfmpuOFec7jyE33bPhikgpr+TAWPX0WrJB3GCyW
	RcN/3901Oquz1s3JEoJo4Q/DexoIOQvxc5GchUjGsHyp9DNxa8Iv/xfBEki403XhZOLnygHbAra
	/GitKPK8/hCUrywMSGdqfRTO4zDmhoHL61cyMAmCC+yMG/+U/rT3+WH4GCHWlqnGqYNRs/J4xSr
	t7HVPST4mbwAahbVrrbIJ5M1XW3Ll9et6gplAQ==
X-Received: by 2002:a05:693c:2a07:b0:36d:4135:cd7 with SMTP id 5a478bee46e88-36f75a27e38mr8089948eec.18.1794072438631;
        Sat, 07 Nov 2026 09:27:18 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa999654sm16328165eec.27.2026.11.07.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:27:18 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: willemb@google.com
Cc: Kalpesh Solanki <skalpesh942@gmail.com>,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK
Date: Sat,  7 Nov 2026 22:56:54 +0530
Message-ID: <20261107172654.302210-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107162649.282982-1-skalpesh942@gmail.com>
References: 
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

> Should this be
>
> Fixes: ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype of the tap device from userspace")

Yes, will update the Fixes tag.

> Cast to unsigned short in these comparisons?

Yes, makes sense. Will cast to unsigned short in v4.

Thanks,
Kalpesh
