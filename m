Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E62494D8;
	Sun, 20 Sep 2026 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789945614; cv=none; b=bLr4BNjtZzliir6931GliYe/F7XPoeYS+1BsIQac5YHyUDeunyYCDt4fsL6BNrC8kGfyZS+67CO4T8c84LMfRRyhrcPpmRF8UtfzFZBYit6ziGPbdFhvomeq1yeUKHyB6ZUmtu9QCkYr0SzmU3LSvwfyM+TwA5kfP/H7auP3jkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789945614; c=relaxed/simple;
	bh=H+n6+CId81TrZ+wN/Oy/vamTpFirRv+qo4WGelxQrtA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n6AJwi9TDr+M1v3c1U8l9Ss79KROh+Kuxn5Nu0fBZf1YVHYHAYvPjicvWeGd6sEugxoDnpggVnO2ymKbtmwkBHq+2SaFxUCbYByKCdXnOOnb+0VEVC7l+/sVlK+Pz0GPKCI6ONOWG0XLlicYjwacBGDNri/stmNQgP3MiMwMN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lErufCbO; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lErufCbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789945601; x=1790204801;
	bh=H+n6+CId81TrZ+wN/Oy/vamTpFirRv+qo4WGelxQrtA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lErufCbOnfcuG7xPyH6wz2o0h7Bndmuy2KRiSWKHBtjLOV1twJbOvnPHnDqKEOCiy
	 Ct9J/8mgqRdvKo/VqG4S+AGYfuQsHn4rz/0GfDtb5tWx0+3MTj7CSQjI2OkiCyRX54
	 d0TS8DkZo9lC47yIpMAfL963VPp7GDcN5oNEPCLmbXGdeDkfzcOO5J0dE+j3fp8d0z
	 TpGSfnp8SWg7EqGTuxexXYUBHSrSHvWPH00QXTuHBwMAKmmu399zNw7n9s+gVK0rHQ
	 Meca1ZGw6goDXDBQu9wajhtmdwlhg8SQC73cy5EjEVYYZUlJlOZnl/OXX5dEdIxsz2
	 z6g3hOSbe5r0w==
Date: Sun, 20 Sep 2026 23:06:39 +0000
To: "andrew@lunn.ch" <andrew@lunn.ch>
From: "i.n.a" <quiet-daffodil@proton.me>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC] Appropriate subsystem/UAPI for Semtech SX126x packet radio support
Message-ID: <4vyyH7e6jQ1f1QSNRo16qvvSXxieE4qNs02suWZW-hC6P5pzxq8wmywfogCLRsj-_oucoBZRFxccllsuEPFGqkqTz9TF1h52zWaViQqzDkE=@proton.me>
Feedback-ID: 199628520:user:proton
X-Pm-Message-ID: 25cff51f51ecbdb915ec470db5cd5ba2d2e02f9e
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>Is stacking protocols on top of the MAC that different to IEEE
802.15.4?

Had a look through `mac802154` and `ieee802154_ops`, the hardware boundary =
does look quite similar, particularly packet TX/RX, start/stop, TX power an=
d energy detection.

The main differences seem to be the 802.15.4-specific parts such as channel=
/page addressing, CSMA parameters and address filtering, versus PHY-specifi=
c configuration for LoRa/GFSK.

Would it make sense to investigate factoring out a small generic packet-rad=
io layer beneath the MAC-specific interfaces?

Thanks,
Ina
