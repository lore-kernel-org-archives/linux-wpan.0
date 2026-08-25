Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087846EF87;
	Tue, 25 Aug 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663732; cv=none; b=VG9bcL+psUj3QLoZ1Xw+OqaLCK20cDnAnPZbIPutigHvDtByXL2CYz3eJSGXXieEOXbVeiTIDfcB6PwNwSa/biKl9MjlE1/vxb3rkWCv4hDS5hWgMQRoDUF+31no2YxBdrhwCXKnoql81Yep3vndnZjSAbcy7uNbIV4JKc0g6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663732; c=relaxed/simple;
	bh=iFkE1NuK71Wwo+oFT8GDaqnD6eoUzuoarnUlASExOYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmyGsEPZYYvofp/zQ8+nUMPkgXUyZZYq4dd2jUSK7Ty1dfGaEPQunqJ7JpJKXJmfVbjlXiIKuMDKYyeqnhUoKroWIcG/JNhaOgywfvwdyevvR9B4xbWKoB1Y0ZuqgDrLUm5uZpYUmH8mIvUrQZmzMpZvpad0kSeWkUe3wR4Vf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wdz6UTI/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wdz6UTI/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E7F191A176A;
	Tue, 25 Aug 2026 13:15:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB49B604C4;
	Tue, 25 Aug 2026 13:15:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34A1D11C795C7;
	Tue, 25 Aug 2026 15:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787663712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rg8ZzhvujBAEPNbXyafXwH9++4nKhKyZjGbNzNeNwQI=;
	b=wdz6UTI/6YCF8O2X+lb+Vrf14WgjoqgLQa7P4RCYh+TqBMtlz7AFyO00P3xVzmfq/Zi5hS
	b6XOXcV/wAjy6dkf2RvG3vaRK5DKPGwjQxPvMjVMdZESnqtaNXT4nNr2YnWtrk3DODUXaF
	gK2PJZGjkwgVxhD6Vt8RNmVbciN2qjJsFwgKumXaPehy9f+qaHdBkHgskqhScxJkKJXjGn
	K4J8MTmhIY5FDUWhnEChNlpWRVhanIk/01kGJo+vKvm1wRoEbKp+PoElPKbKGZCOjwSOyj
	DvmxDRTNnCId1h2/6z26oJX+AAfVg0+TRP6N+4bTk5lNGeObroT9C5BiXAvHSw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mac802154: fix data race and NULL deref on
 local->assoc_dev
In-Reply-To: <20260824175938.11143-1-skwkevin@mail.ustc.edu.cn> (Kaiwen Shi's
	message of "Tue, 25 Aug 2026 01:59:38 +0800")
References: <20260824175938.11143-1-skwkevin@mail.ustc.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 25 Aug 2026 15:15:10 +0200
Message-ID: <87ik4ygx41.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Kaiwen,

On 25/08/2026 at 01:59:38 +08, Kaiwen Shi <skwkevin@mail.ustc.edu.cn> wrote:

> `local->assoc_dev` is accessed from three places with no common lock
> and, on the read side, no NULL or lifetime guarantee:
>
>   - mac802154_perform_association() stores the coordinator pointer in
>     it, then blocks in wait_for_completion_killable_timeout() for up
>     to 10 s;
>
>   - its clear_assoc label sets it back to NULL;
>
>   - mac802154_process_association_resp(), which runs from the
>     rx_mac_cmd workqueue, dereferences
>     `local->assoc_dev->extended_addr` with neither lock nor NULL
>     check.
>
> The dereference races with both write sites:
>
>   1. NULL dereference: clear_assoc() stores NULL while the RESP
>      handler is between loading and dereferencing the pointer; the
>      subsequent dereference of `->extended_addr` on a NULL pointer
>      faults.
>
>   2. use-after-free: mac802154_associate() frees the freshly
>      allocated `parent` in its free_parent path after
>      perform_association() returns an error. If the RESP handler
>      still holds the now-dangling pointer, it reads freed memory.
>
> No existing lock serializes these accesses.  The
> wpan_dev->association_lock mutex only guards the coordinator-side
> parent/child list (mac802154_process_association_req() and
> friends), which is a different data structure, and it is not held
> while this device is associating.  The writer blocks in
> wait_for_completion_killable_timeout() for up to 10 s after storing
> assoc_dev, so the reader on the rx_mac_cmd workqueue races with both
> the NULL store in clear_assoc and the kfree() of the leftover
> ieee802154_pan_device in mac802154_associate()'s error path.
>
> Add a dedicated assoc_dev_lock and hold it around all three
> accesses; the RESP handler additionally validates the pointer before
> dereferencing it.  This is a per-field lock so it cannot contend
> with the completion logic.
>
> Fixes: fefd19807fe9 ("mac802154: Handle associating")

This likely deserves a `Cc: stable*` tag.

[...]

> @@ -613,7 +615,9 @@ int mac802154_perform_association(struct ieee802154_s=
ub_if_data *sdata,
>=20=20
>  clear_assoc:
>  	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
> +	spin_lock_bh(&local->assoc_dev_lock);
>  	local->assoc_dev =3D NULL;
> +	spin_unlock_bh(&local->assoc_dev_lock);

Is _bh really useful here? Isn't the dereferencing always happening in
process context?

> @@ -626,6 +630,7 @@ int mac802154_process_association_resp(struct ieee802=
154_sub_if_data *sdata,
>  	u64 deaddr =3D swab64((__force u64)dest->extended_addr);
>  	struct ieee802154_local *local =3D sdata->local;
>  	struct wpan_dev *wpan_dev =3D &sdata->wpan_dev;
> +	struct ieee802154_pan_device *assoc_dev;

The below block can be much simpler: just cache the extended addr of the
assoc device for the time of the check.

>  	struct ieee802154_assoc_resp_pl resp_pl =3D {};
>=20=20
>  	if (skb->len !=3D sizeof(resp_pl))
> @@ -635,9 +640,15 @@ int mac802154_process_association_resp(struct ieee80=
2154_sub_if_data *sdata,
>  		     dest->mode !=3D IEEE802154_EXTENDED_ADDRESSING))
>  		return -EINVAL;
>=20=20
> -	if (unlikely(dest->extended_addr !=3D wpan_dev->extended_addr ||
> -		     src->extended_addr !=3D local->assoc_dev->extended_addr))
> +	spin_lock_bh(&local->assoc_dev_lock);
> +	assoc_dev =3D local->assoc_dev;
> +	if (unlikely(!assoc_dev ||
> +		     dest->extended_addr !=3D wpan_dev->extended_addr ||
> +		     src->extended_addr !=3D assoc_dev->extended_addr)) {
> +		spin_unlock_bh(&local->assoc_dev_lock);
>  		return -ENODEV;
> +	}
> +	spin_unlock_bh(&local->assoc_dev_lock);

Actually, even simpler than using a lock, since the only information we
use from assoc_dev is the extended address, why not just caching the
extended address value directly in the local structure?

Thanks,
Miqu=C3=A8l
