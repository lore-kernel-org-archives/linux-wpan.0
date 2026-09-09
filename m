Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D27352026
	for <linux-wpan@vger.kernel.org>; Wed,  9 Sep 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966989; cv=pass; b=NcRN4eWM5gVIDGqPIIHcb7rE12E+Vmz8fhSbxCdZU/dXvujBE39hfmMgLS3XCIKTXq/o8gzuiALCRdCYdeucv+bIn/2pFjHLsZMcb3RcVAAad+WRgJjFkgsGcytQNAnJW8UQG/OEwjNVzwygSoG+zlSUROk8zXjDTTh7V7Bcs44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966989; c=relaxed/simple;
	bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f04AHQcgAXVkGJNfxKfsFS4V2L4QRuG3GSo/Wngo8GVGeykHIbA1/wggHIK8eL4NeRfYevTHHJxqcXRgtnLO1crqzDY8qnkl28g3hItTMPVTy97FUG/JnBsETXCw9spOcEUjMgqHZUS94S4hTwIdmkOvSilt5Jnviz1dlVUarvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdIrTcjb; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdIrTcjb"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso260086a12.3
        for <linux-wpan@vger.kernel.org>; Wed, 09 Sep 2026 08:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966988; cv=none;
        d=google.com; s=arc-20260327;
        b=ble7ywgh3WMmaYTgGVatFtCAu7pqwPHRa6FPdXQYZg2Qm+sFIT6GgkmM/eTOnpasDa
         IZ6HZ2BgibAYpfxXLSkJ86a1ht0ippxuXO9+I6L2bLUHTHOKtFUAYD3oMxbHS9h3zxfU
         TkWMVR+ynfiq6/tSgoIjZ7Ka3Y63xOVXzitEqm3t9oCFvwRqCLR2WXBE/R5epeA+m9vM
         m9p2buElSFVe3XBGnOuHTP2Lc/kK0hF8osCJ6Wc4sIifKvcLk+2dLd2FWBo8GfoGZCbB
         y8OAWmuawzI9jxH11m5j5+qhJIclGrmYeFkYvzXA8k17mOKjPAvRim+bXkVGNAe0KSNY
         zsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
        fh=mBgMmdRcKsBFdT1eyexcwu9IYL0PeHOM/iPejJdPwwI=;
        b=L0wptmWwOpwwAaXjpRJSpWrx7LHPafR9yjGM8N3LEFS4dzIDOI1xABid3KCNssXCm6
         M8OTwGxsl/wTsV3wdl9l9EdUfBCC7UMY76zYC/CoOv2YyG1e5N2i8xKI9N9amzanBrIf
         v3swTr2pi3wHjWb7MPhsCyM1p1A7+cvnkJ/UnH9FZKa/LfyIUwOI1WNGGVdDNxUXqyM1
         mV3hekHuiEbM2IITHtkmqYCxbYEgJoTZ/fzU61GRdgjQ3wIPmdWBKwYmaIm4CzbXPdFx
         FI07XGanlhoohSTaO2kF77iCOqN0BnRup8UC2/HBh9V2R89ZjNBr+tKig+TZxPn1Rxmu
         qIXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966988; x=1789571788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
        b=NdIrTcjbI84LlgQFZkH2Tggffm83Kht3pHZZcYrhzeVqRIj+dP6NoY9sQFZ0loZ7RZ
         aJ8c86lixckM9xMQ9A8+y8HzLSnRhJo/9+gx+DH8SLDQG2DIX54Lxcyn+qzAROLQghr/
         omXOebIkFWewVsfh4pMak3MYSxbw7VtuAGICjrfk7rkY/sCF+jqH5ZdBFEWqWnYgFufG
         Kn8Q6FHpEpGpJEesCcTryYFOI1vV1xkc6TJrNuYGXtu/0LOAku70Fs0T8RXBRBEcDY7A
         cLm58M+QG6SZqVgEtiU7d81XmIAeoZSQRbaMD01NTVh/XyaxD0RxRKtJsFcY5MFQCBbP
         b6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966988; x=1789571788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SH32ZFxox0giLDqtaEHI/YB9kcrgRu6UQ2sDr9hVwuU=;
        b=jhER0TKxFUoIXEjpkEdxo3i0ELkdA3kAJlWO4O2ZXDNtLqIOQbE7L8iyosbKoQEbXz
         QXL+1aO6/mJ8ouXp5gGoLj1YAiS2TmpGx5DqHw6IsaSviFn9bQYhzh6PaMD13V3e2lUS
         OJGTvfaxH5SiTLDHumtWMELhn/p3Uxo+goyZ7lA4LIvk3AR8Fj8ghTP9B4cvsCORz40E
         yJfWeu5G74y0fzobYGkqNqACPoY7ZxvV+oleOtblPxz1zO5ZYOKf2uTGqOxAE06KKeLe
         Zdf6taL6MUFaYlwwGf6QU3VThHHN3wmU4VmZeN3A3hR1IZkbwT/7NbbIUGR8eWrZETxt
         XH+w==
X-Forwarded-Encrypted: i=1; AKwUvBzV/pMY7pPW9RwEAQuM6A7X/rXj+ZmH/cUOOHDwFTyLkQfreATT9xeKsr8z5xNqrkFRaC6r3KBWUYiq@vger.kernel.org
X-Gm-Message-State: AFuF++l6Yu4QTgkVAwif6UJLDU7Ozw/oO/bIrQa8ulFXvvAho2ZxfF87
	pWmcd/6j1m/sd7XfHBOHDDNZ82YsCqQxIggl71DGMO0Apkmrvq6YUJ45FOWJkCf3W9FpWuTg1V0
	5QH8JYHMSCFM9kbzpDTS4E1MA6D4/Fyk=
X-Gm-Gg: AYBFou0VgS8yoSX3UZ1RKvN26/yIhbh+N+VPBwhVrQEtgP4QU934vQPBQCZHyhI1DAc
	hu8V/C3XdRn51Yo1PYe32749mMDjQe1Wnvn1SAMHclTTUxSrg+CPJ95DDEtPgrDiY9x7ZLmbJeQ
	mqulnFmiCuoXLsIkIKy4dAVdM6Oj7hkA2jiPbM1MxUo6QaxM50DMgZKURS6D2/KoDNHxqCGfBYk
	enGJlWgZwtCijUJISp7+6nCE7zPOsa1DzaCT6UF8qU/UVfe98eW8Ujc3RrlbJxzhYTO9qpOgJls
	G0JRmabcOplqM/QRUsutl5Xg2EIzmC/QfRqapN1QyysGwY1ZsyvxLt7h5I+urwMVKSNUaizfPt2
	EXKqswOxWY69qJw==
X-Received: by 2002:a05:6a20:914a:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-3dacbf56563mr2350571637.25.1788966987687; Wed, 09 Sep 2026
 08:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908203533.102378-1-adrianox@gmail.com> <87jyousvye.fsf@bootlin.com>
 <CAMGU2hX9GSFUqZZCx6j8wRbSCSi92bn24XmxNOXLoNc8iYqViA@mail.gmail.com>
In-Reply-To: <CAMGU2hX9GSFUqZZCx6j8wRbSCSi92bn24XmxNOXLoNc8iYqViA@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 9 Sep 2026 12:16:16 -0300
X-Gm-Features: AcwNN1V85pBVOpH70K4-xrUqSi1Bg_3u1JEq5vMRJMne0_aWS6Du7ciFoVo4mXs
Message-ID: <CAMGU2hURuqU3iAb4xE2dNJq7qMZUErQJVbzsR8vkriJJnqv93A@mail.gmail.com>
Subject: Re: [PATCH v2] ieee802154: register a device type for the wpan dev
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

El mi=C3=A9, 9 sept 2026 a las 7:06, Adriano C=C3=B3rdova (<adrianox@gmail.=
com>) escribi=C3=B3:
>
> Hi Miquel,
>
> I reworded the commit message and dropped it by mistake
>
> El mi=C3=A9, 9 sept 2026, 04:52, Miquel Raynal <miquel.raynal@bootlin.com=
> escribi=C3=B3:
>>
>> Hi Adriano,
>>
>> On 08/09/2026 at 17:35:33 -03, Adriano Cordova <adrianox@gmail.com> wrot=
e:
>>
>> > cfg802154 never assigns a device type to wpan interfaces, so their
>> > netdev uevent carries no DEVTYPE key. Mirror cfg80211, which calls
>> > SET_NETDEV_DEVTYPE() from a NETDEV_POST_INIT case, and set a new
>> > wpan_dev_type so the device is typed DEVTYPE=3Dwpan.
>> >
>> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> > ---
>>
>> Diff is identical, why didn't you kept my Rb?
>>
