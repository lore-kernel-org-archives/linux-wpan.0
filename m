Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F068468;
	Mon, 11 Nov 2024 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354114; cv=none; b=bLUXOeKDYC7e+nBa6hXx9HYr+N3Gaw15R8fdl8DWVHi1oVdzQaf7+fIp6E5Le70hztbG+CWiitYzSTsUIquOCmLiQsU3xV0cVriWVH/xIVW2cTwsVD5aIoNKEpDJAQ7eAgUp8XUhqal7odQ0wN4Ijz19q3s/AfluH3npxq13tMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354114; c=relaxed/simple;
	bh=HvtbSZZwW/94hc0yedSvevfCyjQJvBnL2Oi436I266o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxPGiQoDYgXb1/RiB8aUmNapx9lQyj5N748ayGXaOwQCBttytM6HZwvqXUq6hOKHl99g6JFIut6jCANG40w6Rue4hGbhZHVXB4OA0rgtxRbdMGeEJtcmpezrrCG3pwjwCZKpFsKmSxviuBIdnCea1RG7LihYla0hablokYPtnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O72Npz6G; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O72Npz6G"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22980E0004;
	Mon, 11 Nov 2024 19:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731354109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT6DCB0BsRdVNbP12kPjuQ2yR+q5zf5Qpbswmr5NQcc=;
	b=O72Npz6GNJpksSqaVGLcoSBRhty5hOtH4TnWqoPv+l0UOIsohr4BLORmzjfsUnGHy7fpIG
	QYCk4sUycbjJ/IIRoZBXotzHdA4gk39UvT2U7xbZLF7ShV7QmFgREesxWxJaEE/IPThb1S
	Sv0nd4S3POUWScHPU6bDIEIOfp/rja5Bn24mzEELfKLdQuqmlAWXJAkt/fvfsSe8v7RKrD
	JBmTa/FxAMkzUynjogVaZzQdgVia3CH1n+sEEmE4ImQHTJuEKO20bYAoPzhtYtyVwNLvKP
	7z6ynJgxmn/+TInhAB3JBEQ4Am5jQ+zvAcBqj3Y1OVlZpuN3G21oDMZ2mkuZuA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  lvc-project@linuxtesting.org,
  syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac802154: fix interface deletion
In-Reply-To: <20241108124051.415090-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Fri, 8 Nov 2024 15:40:51 +0300")
References: <20241108124051.415090-1-dmantipov@yandex.ru>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 11 Nov 2024 20:41:48 +0100
Message-ID: <87v7wtpngj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Dmitry,

> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -669,7 +669,7 @@ ieee802154_if_add(struct ieee802154_local *local, con=
st char *name,
>  		goto err;
>=20=20
>  	mutex_lock(&local->iflist_mtx);
> -	list_add_tail_rcu(&sdata->list, &local->interfaces);
> +	list_add_tail(&sdata->list, &local->interfaces);
>  	mutex_unlock(&local->iflist_mtx);
>=20=20
>  	return ndev;
> @@ -683,11 +683,13 @@ void ieee802154_if_remove(struct ieee802154_sub_if_=
data *sdata)
>  {
>  	ASSERT_RTNL();
>=20=20
> +	if (test_and_set_bit(SDATA_STATE_REMOVED, &sdata->state))
> +		return;
> +
>  	mutex_lock(&sdata->local->iflist_mtx);
> -	list_del_rcu(&sdata->list);
> +	list_del(&sdata->list);
>  	mutex_unlock(&sdata->local->iflist_mtx);
>=20=20
> -	synchronize_rcu();
>  	unregister_netdevice(sdata->dev);
>  }
>=20=20
> @@ -697,6 +699,8 @@ void ieee802154_remove_interfaces(struct ieee802154_l=
ocal *local)
>=20=20
>  	mutex_lock(&local->iflist_mtx);
>  	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
> +		if (test_and_set_bit(SDATA_STATE_REMOVED, &sdata->state))
> +			continue;
>  		list_del(&sdata->list);

Why not just enclose this list_del() within a mutex_lock(iflist_mtx)
like the others? Would probably make more sense and prevent the use of
yet another protection mechanism? Is there anything preventing the use
of this mutex here?

Thanks,
Miqu=C3=A8l
