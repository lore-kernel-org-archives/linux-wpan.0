Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8D436BC8;
	Sun, 20 Sep 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909855; cv=none; b=Tyfoh/ocHXjna6bp1wzfMjCcUWwDW/cDQzGI/GxCIo56hfaCzPUBfKECRAp3K49GP8P36aJgJ9IwDfcwFJ5lRv7RV3l2Uv2u7a4meuEKlMZv1tYFq6Y7OWNAr/55yUrkJesYKlkmp/MRFTlNCYpi0d+QpuRCu2v/Fib3DgUvQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909855; c=relaxed/simple;
	bh=1VFQdq98VWzSvyCfjw8VGmS+UXUQ9KHUBodyapcL/o4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mr752CKky/lkJNinxLWq8VnzASvUEeZ+aZbnD0oU6qeVCqDe3RpsG4+yvcpfnugM6BwtG1//T+K4bLNWoiwad2GzKt2tM3bgTnq8Bx8isI6IdFhG5cIUigNJBHBZ8tFx6g2SUmEPcXqg9LyZoqhVsa52az/+qaYV1VelKZu91jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ugecy1cD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ugecy1cD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BF5571A08D2;
	Sun, 20 Sep 2026 13:10:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 836E5604C9;
	Sun, 20 Sep 2026 13:10:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2B551032906C;
	Sun, 20 Sep 2026 15:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789909844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QYnRZvFpmS3H8pe6bMUWA1PeBW7A6p0m180UqcaFJ2Y=;
	b=Ugecy1cD/0SjjXpul+Nt5694nKLYIMh/qni4kOJuEXE4FrO3ulQHfJRUXZ/hGdxiWRLoFG
	e/9nupAUptugQtLuxvw2EmSyN7WEcyP6Qi226y5IfATBuoKUDaxv9pyYvS49inAr1V6y68
	zWHOi34wmh/m1Nw6t7OTOzQ4jb63HYgIrRPJHYtVkTacJgtQII9g62tZAyk91lDM9DaicP
	KOvFmobiZXzhP/tyecEjBPIam4e+H2i8HSJWi1CATy091ALhBDU4mOuxShN9QDmmaXkpnZ
	mWoWvw/3jqEbGx9ruwr5DTDf/HEEun7WZfsmYrWL/OtDh1webMbMFuIhumdqKw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac802154: rx: fix beacon/mac_cmd skb leak and short
 skb_trim underflow
In-Reply-To: <20260919213637.3314421-1-benquike@gmail.com> (Hui Peng's message
	of "Sat, 19 Sep 2026 21:36:36 +0000")
References: <20260919213637.3314421-1-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 15:10:39 +0200
Message-ID: <87pky89igg.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 19/09/2026 at 21:36:36 GMT, Hui Peng <benquike@gmail.com> wrote:

> Fix two sk_buff handling bugs in `net/mac802154/rx.c`:
>
> 1. In `ieee802154_subif_frame()`, the `skb` passed by
>    `__ieee802154_rx_handle_packet()` is already a dedicated
>    `skb_clone()` owned by `ieee802154_subif_frame()` (with `skb->users
>    =3D=3D 1`), and all normal return paths consume it without extra
>    reference increments. However, the `IEEE802154_FC_TYPE_BEACON` and
>    `IEEE802154_FC_TYPE_MAC_CMD` branches call `mac_pkt->skb =3D
>    skb_get(skb)` (incrementing `skb->users` to `2`) and return
>    `NET_RX_SUCCESS`. When the worker later calls
>    `kfree_skb(mac_pkt->skb)`, `skb->users` only drops from `2` to `1`,
>    permanently leaking every received Beacon and MAC Command `sk_buff`.
>    Assign `mac_pkt->skb =3D skb` directly.

This is okay and should probably an independent fix.

> 2. In `ieee802154_rx()`, when `IEEE802154_HW_RX_OMIT_CKSUM` is set,
>    `skb_put(skb, 2)` is called without ensuring 2 bytes of tailroom, and
>    when `IEEE802154_HW_RX_OMIT_CKSUM` is not set,
>    `__ieee802154_rx_handle_packet()` calls `skb_trim(skb, skb->len - 2)`
>    without verifying `skb->len >=3D 2`. Ensure tailroom with
>    `pskb_expand_head(skb, 0, 2, GFP_ATOMIC)` and drop frames shorter
>    than 2 bytes.
>
> Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
>
> ---
>  net/mac802154/rx.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 19b5382e85a8..dbdaf5962ca7 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -287,7 +287,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data =
*sdata,
>  		if (!mac_pkt)
>  			goto fail;
>=20=20
> -		mac_pkt->skb =3D skb_get(skb);
> +		mac_pkt->skb =3D skb;
>  		mac_pkt->sdata =3D sdata;
>  		mac_pkt->page =3D sdata->local->scan_page;
>  		mac_pkt->channel =3D sdata->local->scan_channel;
> @@ -304,7 +304,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data =
*sdata,
>  		if (!mac_pkt)
>  			goto fail;
>=20=20
> -		mac_pkt->skb =3D skb_get(skb);
> +		mac_pkt->skb =3D skb;
>  		mac_pkt->sdata =3D sdata;
>  		netdev_hold(sdata->dev, &mac_pkt->dev_tracker, GFP_ATOMIC);
>  		spin_lock(&sdata->local->rx_lock);
> @@ -487,10 +487,15 @@ void ieee802154_rx(struct ieee802154_local *local, =
struct sk_buff *skb)
>  	 * solution because the monitor needs a crc here.
>  	 */
>  	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
> +		if (pskb_expand_head(skb, 0, 2, GFP_ATOMIC))
> +			goto free_skb;
>  		crc =3D crc_ccitt(0, skb->data, skb->len);
>  		put_unaligned_le16(crc, skb_put(skb, 2));

This, why not.

>  	}
>=20=20
> +	if (skb->len < 2)
> +		goto free_skb;

But this? This is a situation that cannot happen, right? Either the PHY
adds the checksum, or it does not and we add it above.

> +
>  	rcu_read_lock();
>=20=20
>  	ieee802154_monitors_rx(local, skb);

Miqu=C3=A8l
