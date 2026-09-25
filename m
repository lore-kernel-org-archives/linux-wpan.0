Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5F2673AA;
	Fri, 25 Sep 2026 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327012; cv=none; b=a69MZovcMGpN0pdVEdo4M/kIMexvwvYaa+FbeSPvIpIgM8K+9mMTOQdgmQ3Pk6LXORt8cVpvEtBsznlQTLbHoEd/th4fupABuqw4c1STaeNsrRTMiLKXwWdDfBSNWPiAddZfOObrhBshFfZPYHHdPpe9mKw2wiPwMahCZqtqCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327012; c=relaxed/simple;
	bh=P8Aw7juCe2KgMXuQOGximN8nLdja9ugNEdFO7iGcWE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ouvmWVHR2GtV0ZtbzzNKCHenHr79kJ6uMlJZG8kVJOHn0bQ+eQOF7q+uEoyMp0Vq5XgiLWgAatyrh0g5LSdPlnX1UGQUbKhedoscPGncKtDodLArN1NBWTI5AzltD5o1bjUcD2lFfyJyDYVkf0MOT8Mq+qGjYiYCWcORE4ifQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B3UmHtlo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B3UmHtlo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7BFD6C211CD;
	Fri, 25 Sep 2026 09:04:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99CCC6073B;
	Fri, 25 Sep 2026 09:03:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B81710329511;
	Fri, 25 Sep 2026 11:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790327007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JibZyF/fRehCmboIlM1nNTSQL8f2hKg+pMPROPG2JqE=;
	b=B3UmHtloWnC+aqmT68I/YIcaq9mGTY44TckiIBeAzpU0V/KrKwlUtbv/t06oxoSW+tAuKK
	UsiKwh/QN3Vu0br6+Hrq6x0g6QHbmN6BayD9VENobEv9L/jac6QSelzWeK7BVU0FeRkh1r
	tbO1kCdgFL2miiY23/08iB3nHfE4UTRPYErUBJxGLLkkgoxt9TcqlCwvyhod4s30mt5RRn
	XCsFJB2dDDk3+8kz4Sppqt5mcbY9phFtFKmVRGX115f5Er+EVG8HKfYMYgoSbrh609NnFq
	UvafxmgZLJDFdUYgEpjNofvycv4o6kljIcqJfTb9NECa/CIMRyhSDYCRrbg/Cg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adi Prasan <itsadi2409@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac802154: synchronize pending transmissions before
 stopping the hardware
In-Reply-To: <20260920170655.608419-1-itsadi2409@gmail.com> (Adi Prasan's
	message of "Sun, 20 Sep 2026 17:06:55 +0000")
References: <20260920170655.608419-1-itsadi2409@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 25 Sep 2026 11:03:24 +0200
Message-ID: <87ik3tn1nn.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Adi,

On 20/09/2026 at 17:06:55 GMT, Adi Prasan <itsadi2409@gmail.com> wrote:

> From: Adi <itsadi2409@gmail.com>
>
> syzbot reports a WARN_ON(current_phy->suspended) splat in
> mac80211_hwsim's mac802154 counterpart, hwsim_hw_xmit():
>
>   WARNING: CPU: 0 PID: 6038 at drivers/net/ieee802154/mac802154_hwsim.c:2=
66
>   hwsim_hw_xmit+0xcbf/0x1540
>   Call Trace:
>    drv_xmit_async
>    ieee802154_tx
>    ieee802154_subif_start_xmit
>    __netdev_start_xmit
>    ...
>    packet_sendmsg
>
> mac802154_slave_close() only calls netif_stop_queue() on the closing
> netdev before tearing the hardware down via ieee802154_stop_device(),
> which calls straight into drv_stop(). netif_stop_queue() merely marks
> the queue as stopped; it does not wait for a transmission that a
> different CPU already passed the "is the queue stopped" check for and
> is currently executing inside ndo_start_xmit(). That thread can still
> be inside drv_xmit_async() -> hwsim_hw_xmit() by the time drv_stop()
> runs and marks the phy suspended, which trips the WARN_ON() (and, on
> real hardware, could still start a transmission after ->stop() has
> torn down the transceiver).
>
> ieee802154_suspend() already knows about this and synchronizes with
> any in-flight transmission via ieee802154_sync_and_hold_queue() plus
> synchronize_net() before calling ieee802154_stop_device(), releasing
> the queue again afterwards. mac802154_slave_close() is missing the
> same synchronization when the last open interface on a phy is closed.
>
> Do the same hold/sync/release dance in mac802154_slave_close() so
> drv_stop() cannot race with a transmission that is already in flight.
>
> Reported-by: syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dadb0bf16414b8bb2d799
> Signed-off-by: Adi <itsadi2409@gmail.com>

We need your real identify.

> ---
>  net/mac802154/iface.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 31353795fa24..e29f225c0dd1 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -313,8 +313,19 @@ static int mac802154_slave_close(struct net_device *=
dev)
>=20=20
>  	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
>=20=20
> -	if (!local->open_count)
> +	if (!local->open_count) {
> +		/* Ensure any asynchronous transmission already accepted by
> +		 * the driver (i.e. past the netif_stop_queue() above) has
> +		 * fully completed before calling into ->stop(). Otherwise
> +		 * drv_xmit_async() can race with drv_stop(), which some
> +		 * drivers (e.g. mac802154_hwsim) do not expect.

hwsim is for testing purposes, not sure this is a real use case.

> This mirrors
> +		 * the synchronization already done in ieee802154_suspend().
> +		 */

This message is 100% AI generated and can be dropped, unless there is a
real info carried, but I don't see it.

Yet, if we can get rid of these by just fixing max802154_hwsim, please
do it.

> +		ieee802154_sync_and_hold_queue(local);
> +		synchronize_net();
>  		ieee802154_stop_device(local);
> +		ieee802154_release_queue(local);
> +	}
>=20=20
>  	return 0;
>  }

Thanks,
Miqu=C3=A8l
