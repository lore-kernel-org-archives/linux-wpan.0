Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A045D918
	for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981745; cv=none; b=TsC1rholareH9w1ZQyqkVwonkDq3JujKkJ48pUlyecCHkOqUlIZDfQEN4xwt1yzIoGKSUtycA2mkkGtjgj+SNsVenFVt04yEJZNMbrRosWZuTUAZ0bxLcZLeqyh1nHzwXMAgxddTBL2oqxUtIYdMjcrRzJHtr82YCRAIb0jK7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981745; c=relaxed/simple;
	bh=SBPNKt21pg+g6fDAxFgLSyTyhC1gJ7gWZdrt1RHNvd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4Z3bGTa8itzFZ+7pYjPHXuXxnxcGXUX1aJkvPsfY8chviqmjyTDTmrpALJQ3iFxEAofDD3xC1wBUi+r/ZCvEP4zb8OuAj9p+mnoJ1NIDmzfNMwxYwLSrD04m1CVjoOhrMvHrxw6HANur4YMOui4n6ugKk3v2mjDPRjLzMKIgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm+/X7EP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm+/X7EP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so13845315e9.3
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789981741; x=1790586541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=if/RxwdeVH9lYKeVFMTHpGthhaeX73Ye43H7ksvDSZk=;
        b=Jm+/X7EPpuQKERZwkozJ0RXF/AdVMyW9TIDomvzmypOcf64BruTvy0EpGBKreR1uMi
         FT8+GFX5snXQv/wPb2KP0noHEWQWXiZ6PCM+jdg2zUHKfIefIPoyQWfuYqtzb9pHta6a
         oakXI5zq9W/5nlWAz00/M7uKmmkcPq1VRqqWH6UZAdW959RVUwFFhSq4oVRvkFZxyrO1
         ki/vWEa5qj/cpm8khvkZPmwK3IrzkQEFxV0X3zR+ApGoUY8KB1CCo4ghOsTHXF5L4xlv
         KHki7VoteWH6MLDOV1C34TeOdvBS2gMrLLPtii/R/hLb3TzLnQp/a1/EH88WxtPCFoUz
         N10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981741; x=1790586541;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=if/RxwdeVH9lYKeVFMTHpGthhaeX73Ye43H7ksvDSZk=;
        b=WrHezq5Qu5VTjE4C+7IxQjJFgwoHYxrKkSv90IwQB+4ZeI5qHA5t2K8HXVetYsauX8
         PKpCg6oS9s987FkSUrrrWT/ocr59bBGSGifhIS8qEjk4u+Iqzqzro43rvkn9s9pYWSYW
         37kk1IQGl8PbZYZCDDlFm/x5GCRhq4iZ+8/UZ/XopubJHn1GRSPkt3VQHfmRshqqKaYM
         Bm/j1OwQ75UddH2cW24quOby9CQ3QmLave1Z4GN/9OrdvotkJaz8rSxCgcu7sPajfgNa
         j3/63uT370H4MKoXruk/HK6WXiF3/9DtlrzJNKOYmhD/tncs3JCxUBfc9BUhf8teq849
         RRZg==
X-Forwarded-Encrypted: i=1; AKwUvBw082oIA/aYUGENnkMe9/mTdMAEKw6km4+KMIg/uYdva+JYnyZp+UqLm6fhncC9elL2adaCHu8TyPiv@vger.kernel.org
X-Gm-Message-State: AFuF++kYRTmK7jmdJejY7VMRYgYA2XkXoPdXg2/Zp99701M/Y/nOpN5j
	SLVPRzeKMvTvl7UZHaehQ7t7d0k2RgPJM0UYxFu0boXFsw1gS9RH6sdt
X-Gm-Gg: AYBFou1pzwtWmW93wwiyHdvnc4+McUiwPJcCdJPabxHsettgaz6Dpzmm9RghlsFi8gX
	nTf5tph+FQgFvJ/IryTcxtgncbkoqxjpWc+umCiPdHSdcVrqz+C7dZjtFt7tIHW+2fQv8tm4P0m
	Ff+YRsDWEhgAqb+veBe2Sc0UzPXTPqHftNuD+aruxibm6Af1j2VARlOSCYWl3Wbg8sCKKXQAUVG
	chu1IIxGgS2jRYLQjoloUcwoqpxhj0fREhvVjgqsgCrbxYa9yG2s4Ql2LQynnNga1agz1Q8u337
	q5icighwXKSJEXFZtAmEXIuAwJxQJsOwJRxvg9fv0hANhkdpxlzcTcBfx12VvQ2bOUsPCsNRhHA
	p/NQ1sjhxR/Kxqda+AgFmL8NX9ntjV0hn1KT2Cwg94mZlSDm2Np90LcwiNBVby+2y5vid3HcoUx
	VPrXd6CzvVhixYLvs1fY2c8cR40ajMYjuL0WHbFr+8GvsGiaZWeOYlrZM/TTafdG8jLRy2Av384
	MfSFw5GDeUnMmsWyMThRvgCFH+nMJ3EIg4=
X-Received: by 2002:a05:600c:1e24:b0:49c:fc6e:a3d2 with SMTP id 5b1f17b1804b1-49fc574f74bmr135450395e9.17.1789981740730;
        Mon, 21 Sep 2026 02:09:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd074336sm210758555e9.8.2026.09.21.02.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:09:00 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:08:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Harry Morris <h.morris@cascoda.com>, Alexander Aring
 <alex.aring@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] ieee802154: ca8210: prevent stack buffer
 overflow in ca8210_rx_done()
Message-ID: <20260921100859.3869db3d@pumpkin>
In-Reply-To: <20260921074205.2289211-1-benquike@gmail.com>
References: <20260919213637.3316595-1-benquike@gmail.com>
	<20260921074205.2289211-1-benquike@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 07:42:03 +0000
Hui Peng <benquike@gmail.com> wrote:

> In ca8210_rx_done(), the packet length len = buf[1] + 2 is only checked
> against CA8210_SPI_BUF_SIZE (256). When buf[0] & SPI_SYN is set and
> priv->sync_command_response is non-NULL, memcpy() copies up to 256 bytes
> into priv->sync_command_response, which points to a struct mac_message
> object (sizeof(struct mac_message) = 250 bytes) on the synchronous
> caller's stack, overflowing the stack buffer by up to 6 bytes:
> 
>   BUG: KASAN: stack-out-of-bounds in ca8210_rx_done+0xc4/0xe0
>   Write of size 256 at addr ffff888001907660 by task init/1
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x70/0xa0
>    print_report+0x153/0x4c6
>    kasan_report+0xf1/0x120
>    kasan_check_range+0x125/0x200
>    __asan_memcpy+0x3c/0x60
>    ca8210_rx_done+0xc4/0xe0
>    ca8210_spi_exchange+0x12e/0x190
>   ...
>   The buggy address belongs to stack of task init/1
>    and is located at offset 32 in frame:
>    ca8210_spi_exchange+0x0/0x190
>   This frame has 1 object:
>    [32, 282) 'response'
> 
> Bound the synchronous response memcpy() length to
> min_t(size_t, len, sizeof(struct mac_message)).

Why min_t() ?
len is unsigned so min() is fine.

Shouldn't there also be some kind of indication the data was truncated?

David

> 
> Tested in QEMU with KASAN enabled by passing a 256-byte SPI_SYN response
> into ca8210_rx_done().
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Split the ca8210 fixes into three single-issue patches (1/3..3/3).
> 
>  drivers/net/ieee802154/ca8210.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 01af4f9..c009930 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -697,7 +697,8 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
>  
>  	if (buf[0] & SPI_SYN) {
>  		if (priv->sync_command_response) {
> -			memcpy(priv->sync_command_response, buf, len);
> +			memcpy(priv->sync_command_response, buf,
> +			       min_t(size_t, len, sizeof(struct mac_message)));
>  			complete(&priv->sync_exchange_complete);
>  		} else {
>  			if (cascoda_api_upstream)

