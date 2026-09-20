Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BB47A0DD;
	Sun, 20 Sep 2026 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940308; cv=none; b=YJzRYsWan/DdpGufjNRfoZdugT/mWdka9sQms0MqGtdTpB+ycXSGGUGgK1PN4+qmqQo88fCP7yrrNM/IBs9R+IoylF5bkt5lV6ek0rbrV3Jn7unq2oB7L/Aqa7pBT675EIpHWkEEY9zguTCBnm/Ge1N8fwZ7pvA8Dq/WhQ70Q6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940308; c=relaxed/simple;
	bh=F6fgMVtA9rU80B+XkqplTdTZoU6FIlA73iGwMG04c1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8MQ01P3MY6R4MDClSHwwLycoCbdXIRCBotgF3sZfdziovBf+e9h2MAE5PZnlbtLJYIHuwzMcrLOblZoNkaBclhWgr6FkDpKBk/iLL3t3YgRDjlHtVDXdaCl0tSaKSlltRCxnS7xm0cW6qdTZ1ZE5as2U0awjRYAmhCxccol/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MOBjwMOM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MOBjwMOM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k+k36w6dP1JeDN1FZYWXChhVOCoyU3oPvXqYgWAyDgM=; b=MOBjwMOMpAvJKXKMyaJ9FKDvMn
	fe7gngnv7SOq4t3mdut/J3xMZk0XCPrnE01EOBaDQ1wPFk1Ozzzu1a7b+vg+FVPC7K7lr2E4QXNop
	qh1uz4zVoeEfi6ENE2/pfx0Bob18M3iTPtzyH9OZk22gLbuaUhDe06oCCOjcu8+PiFH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8PEm-006D87-Ky; Sun, 20 Sep 2026 23:38:16 +0200
Date: Sun, 20 Sep 2026 23:38:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "i.n.a" <quiet-daffodil@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Subject: Re: [RFC] Appropriate subsystem/UAPI for Semtech SX126x packet radio
 support
Message-ID: <425865f4-2eb5-4346-a7b4-be89ea7ff8bb@lunn.ch>
References: <HnbG4UMw_4eCU415RUgCB-SE6LmXjFLinorFY6rJXqP5bO7CJzyxEuuNVgDoA1oVs0c0AaqWcfAQdPRORxpRNmlD1iWUzhXqPtq2qByuJcw=@proton.me>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HnbG4UMw_4eCU415RUgCB-SE6LmXjFLinorFY6rJXqP5bO7CJzyxEuuNVgDoA1oVs0c0AaqWcfAQdPRORxpRNmlD1iWUzhXqPtq2qByuJcw=@proton.me>

On Sun, Sep 20, 2026 at 09:15:16PM +0000, i.n.a wrote:
> Hi,
> 
> I'm working on a general-purpose Linux driver for the Semtech SX126x family of sub-GHz radio transceivers, initially targeting the SX1262.
> 
> Semtech provides a portable C driver for the radio, with the platform-specific interface abstracted behind read, write, reset and wakeup operations:
> 
> https://github.com/Lora-net/sx126x_driver
> 
> I'm currently implementing the Linux side using SPI, GPIO and IRQ infrastructure.
> 
> The SX126x supports LoRa and (G)FSK packet modes, but isn't inherently tied to a particular higher-level protocol. My intention is therefore to keep protocols such as LoRaWAN, AX.25 and Reticulum outside the hardware driver and expose generic packet TX/RX, PHY configuration, radio state and receive metadata such as RSSI/SNR.
> 
> I was considering exposing the radio as a character device, for example `/dev/sx126x0`, with a small userspace API for configuration and packet I/O.

One thing to keep in mind is that there are other vendors producing similar devices, e.g:

https://www.microchip.com/en-us/products/wireless-connectivity/sub-ghz/lora
https://www.st.com/en/microcontrollers-microprocessors/stm32wl-series.html

You want to make whatever API you design vendor independent.

	Andrew
