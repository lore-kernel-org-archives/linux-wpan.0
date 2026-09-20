Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7852C027F
	for <linux-wpan@vger.kernel.org>; Sun, 20 Sep 2026 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938930; cv=none; b=fA7qNNtRSrqg+ZjzYCbZjHzphpg4pJHgXBvLcKW0soncWstmwFIkGFS9guIA2zf3k8+NnZgXjTGGmZd5ozQ1slddxAtWf6+ps5hBytfJIQFeQN6dR98r0wTJ1hzaJp0djZCEjaj+RE8G26WUH555J3tXNDwXhleMfejbO33NnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938930; c=relaxed/simple;
	bh=HFa93MfS+wrwGp/JqtOtXzYG/J6s6X+kuscOlYS/4eI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wexs+6ifHHoeLGACAjJjze1fsb3jUUusdkN77eyQcAZxY6kI5TYS+r6bWCsiNHF3ZKPhjI+WAkipiDGhlbdSdVI16uO3ERweoY+3Jt8raYRY+7D4+CmtMnLtInI3GOFngFAECRhLdoasKPMFlCz2gWJDh48AZagIPER/R+WJUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IYl3SEJE; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IYl3SEJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789938921; x=1790198121;
	bh=WPhBeXijAzQsLot7pV+By5H96mMiw8ygo8bPlbPdMGs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IYl3SEJE7vVwf65jaGAKqd3pfMkt44u5ceiN8wv4v0JDSccPYKGpen7Q54ousSngZ
	 Dl3hze41lekomMH6Z+vOA9wHYGxHfJ4PBkE+omxICZVxM5QPFb60VB7ed4D+UNCUBX
	 Zmqtdf5UWp4DIc7g3lip3+PvK2RUIyMCjU0j3xyCM5+uvp7nslECAos6KWKDeYN9Aa
	 6O999SrpJUMzl41bLvn2X07U+gFXtjGK4xpMbSOjpN2hGKrZ51rLJYrdHxIPZwEGPG
	 BdfxElJroFBSDnGKlCb3fdM6wopVtN5fef6WS+6hsyh2+uT2BuPHsDoxLYj2+EiSnX
	 ED7bkeyyo990A==
Date: Sun, 20 Sep 2026 21:15:16 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: "i.n.a" <quiet-daffodil@proton.me>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Subject: [RFC] Appropriate subsystem/UAPI for Semtech SX126x packet radio support
Message-ID: <HnbG4UMw_4eCU415RUgCB-SE6LmXjFLinorFY6rJXqP5bO7CJzyxEuuNVgDoA1oVs0c0AaqWcfAQdPRORxpRNmlD1iWUzhXqPtq2qByuJcw=@proton.me>
Feedback-ID: 199628520:user:proton
X-Pm-Message-ID: b7f2ba2c323823e020ebb27a19c4c2380f45134b
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm working on a general-purpose Linux driver for the Semtech SX126x family=
 of sub-GHz radio transceivers, initially targeting the SX1262.

Semtech provides a portable C driver for the radio, with the platform-speci=
fic interface abstracted behind read, write, reset and wakeup operations:

https://github.com/Lora-net/sx126x_driver

I'm currently implementing the Linux side using SPI, GPIO and IRQ infrastru=
cture.

The SX126x supports LoRa and (G)FSK packet modes, but isn't inherently tied=
 to a particular higher-level protocol. My intention is therefore to keep p=
rotocols such as LoRaWAN, AX.25 and Reticulum outside the hardware driver a=
nd expose generic packet TX/RX, PHY configuration, radio state and receive =
metadata such as RSSI/SNR.

I was considering exposing the radio as a character device, for example `/d=
ev/sx126x0`, with a small userspace API for configuration and packet I/O. H=
owever, before defining an out-of-tree UAPI that may turn out to be the wro=
ng abstraction, I'd appreciate some guidance:

1.  Is there an existing Linux subsystem suitable for this class of packet =
radio?
2.  If not, would a character device be an appropriate interface, or is the=
re another abstraction I should investigate?
3.  Would it make sense for the hardware driver to remain protocol-agnostic=
, with networking/protocol interfaces implemented above it?

The aim is for the driver to be generic across SX1261/SX1262/SX1268 hardwar=
e rather than tied to a particular board. I'm also interested in supporting=
 different transports where practical; my initial hardware is SPI-connected=
.

I wanted to ask about the architecture early, before too much code or a use=
rspace ABI becomes established.

Thanks,
Ina
