Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB811DF268
	for <linux-wpan@vger.kernel.org>; Mon, 28 Oct 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133788; cv=none; b=AtXvQ83n0LdwatF0wHOLeFaJErOG8vycKeIlkvnzIv3vw6JVVCjl+OvtPY1bHIDPUQaSYdZd3cvAGHd2U3KxnUsNiNV75RAzXsWH5HDtVxLDxd1VY8st6nW/AkbdkhciRqsq2oL7wtZmUnt4grJOjMVoz6BJWGxYdw5S4+iy5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133788; c=relaxed/simple;
	bh=JNJOKl46jLJGslGf5ErGbfwDYIGBl5tbyg7Z4INFYnE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oCEGcacLbpKoS5JZj0RsfFOwDmS6ZRJdGlFfvX7b6IDVpG6Pi1bjTkroBV4217yCFwWa7Nl43cwXGaJPp7kbPs0qLMVgAEPgQg7AjQfS64TiW1LxUIjnlZ4/7hTsjH01yGlfp8oYk6hjziHmm/2DD+SX3KWjNZVTnVI7CWU6/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fAbfWwJA; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fAbfWwJA"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730133782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4O8OJBMmnm9/5Y9Az0M1fjT/ZmToxjWCi2Zmw5OLgU4=;
	b=fAbfWwJAKII7zSjhj2Ie8iww6pzvSWrpog9UAo7EosWHY2MI9W4RTI4KYFiybWs6NtduNI
	nmogNGZgJXsxQY5382OFMNyl8/ixOCKC+PeJDWRQXR77aMNNj6qlkGCZDnl5/5xiwS8pUn
	SrCHRMUe/mUTG16FX1WPA0MHFrB+Pbc=
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] ieee802154: Replace BOOL_TO_STR() with
 str_true_false()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <173013100436.1993507.7802081149320563849.b4-ty@datenfreihafen.org>
Date: Mon, 28 Oct 2024 17:42:47 +0100
Cc: Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B24A2C8-B684-4A86-AEC7-198891897F56@linux.dev>
References: <20241020112313.53174-2-thorsten.blum@linux.dev>
 <173013100436.1993507.7802081149320563849.b4-ty@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
X-Migadu-Flow: FLOW_OUT

Hi Stefan,

> On 28. Oct 2024, at 16:57, Stefan Schmidt wrote:
>=20
> Hello Thorsten Blum.
>=20
> On Sun, 20 Oct 2024 13:23:13 +0200, Thorsten Blum wrote:
>> Replace the custom BOOL_TO_STR() macro with the str_true_false() =
helper
>> function and remove the macro.
>>=20
>>=20
>=20
> Applied to wpan/wpan-next.git, thanks!
>=20
> [1/1] ieee802154: Replace BOOL_TO_STR() with str_true_false()
>     https://git.kernel.org/wpan/wpan-next/c/299875256571

I'm actually not sure this works after getting feedback on a similar
patch [1].

I'd probably revert it to be safe.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/linux-kernel/afe1839843d8d4dd38dd9368b2e30f0aa6864=
b9a.camel@sipsolutions.net/=
