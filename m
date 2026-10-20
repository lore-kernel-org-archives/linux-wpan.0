Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498220;
	b=FUDY2Paxu8eT+lzCBISNF6L4rOcKdCtpVeLQDqK3cw39XUD/Re1I2wknXlwhUqbpMELS
	 KDO2qPv3mmn3B/ICAyPp7rOiTxWTnx76n1WVkRcuXnblUXYMXedB5dZT0Q0sFFpRdn3Qk
	 D11kmo3Dh8jqPJ32AyB+GqKAETm6cUmPB/hALA75Cb6pU0KI0o57NmjckYXLdBU0OCKEF
	 eSBiTPCkDDzJUT17BuiAPKLYN/vPGiud+dxOVGVBbqz8QsW6cWcjDdlD120l9oxMnFmqX
	 N/N0tz6eL+FXAYrJ3ZCXqf3Ulu5e8ehzCbA2vicFJ/1gf5lgqAKpe0VZwVVPykcwVcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498220;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=mqRwWa47iC3jnswmJX4TwcHEfSIB/sgNieSNJJSfQ3s=;
	b=zgbtfWDKZayrB5IHSkYEk6Ll7ed0Rjjh9YaX/D4mx5uG+qPBHY5+oDs7KW6zwq0zB1//
	 pyY4Xh1HfQYw/l8MLRoVAJK1/wDRTV9CjBTgfVPBfZ/aZfZxqmU7AXXwLcg+jNHRI+Ebg
	 UlFWwpFugxYQL0cX3X+p71Rf+MmP1CXJpegZNXxfnjLtWQO8wsUm5UNC67D1HgDS6VsQ5
	 R8tNblXJWbpDvxDn2zF3AsguUTPQKwiF29teOPIqnWQ6XdXecZFmcBOcSi4FBlzEd6vPP
	 hBM9Q6H/B6Y+1UPzijRqY6O1dcBMSJpUgCmmnY5N60u1x6YbBHXUIS2nk6UgHNx08yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pcrz7FwR;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867F606A319
	for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 12:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A867F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Pcrz7FwR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=mqRwWa47iC3jnswmJX4TwcHEfSIB/sgNieSNJJSfQ3s=;
	b=Pcrz7FwRGdHDBNIxRXghDLYVYTCQCx8FRkh+C+D5kP7OuX2iW99hz+U8HHUT+5
	Ovog/3y4PcziCSvkjASZbq/bPZniQafneGRxPvY//kBG96frkx5j6jxF4fQBBOWU
	4UpXUsqjV4MwuKw1ZhS1uxHVCHiKaI/2KHk7ffz0kCbUQ=
Received: from LAPTOP-137NTCJO (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3V9IjWtdqwi7WBQ--.40512S2;
	Tue, 20 Oct 2026 20:10:13 +0800 (CST)
From: Jiaxin Li <18135327133@163.com>
To: linux-wpan@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: validate received command lengths
Date: Tue, 20 Oct 2026 20:09:57 +0800
Message-ID: <20261020121009.731-1-18135327133@163.com>
X-Mailer: git-send-email 2.56.0.windows.2
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V9IjWtdqwi7WBQ--.40512S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RmApYUUUUU
X-CM-SenderInfo: zpryijyvtsliitt6il2tof0z/xtbC6gUw8GrXWiXxhQAA3Z

Hi Miquèl,

Thank you for the review. You are right: those per-command checks were
ad hoc and did not follow the message framing.

I see that Hui Peng's series ("ieee802154: ca8210: fix stack and slab
out-of-bounds accesses") already covers ca8210_rx_done(),
hwme_get_request_sync(), and ca8210_skb_rx() with message-level length
validation. Please drop my patch; that series is the proper fix.

Thanks,
Jiaxin Li

