Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FF1B4F1C;
	Mon,  4 Nov 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722341; cv=none; b=q5ueRVOq+0ZrKb9qj8y7nLRt0wOl0BqGIMP53aA8bLwZ5Ik1n62lk8cggfjLRlUon5CSs9VR7kXRWWM6SIkl9V5Y55aTfJKBtaytD7aY2DR26XQFMH9ZAFSGBn5Lg+ngadF5ahAHrFXhDxNU+ZLWiw2XecreNKItfptp5jccaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722341; c=relaxed/simple;
	bh=EzCLeSOSyfEFmgBa90TT86H0T/FhMk6GqzGj5DeaSS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShQ89oAKidYiQ07SHaAi6VOyUK5Bzn6VYv8hsO/2TFz9c25bVmpS8V+KbDXywkM0EDJBgCXGSwr4AA9Txgy2ly5EYgzZpZXOfWLVr24XDUeYH3vf9EPLOiLrDkd+YXPWwdtcjvuhdFE2h8ZiD+4Ra3wHjJyaJcgdEazc5wxIPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYepDbSa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYepDbSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB70C4CECE;
	Mon,  4 Nov 2024 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730722340;
	bh=EzCLeSOSyfEFmgBa90TT86H0T/FhMk6GqzGj5DeaSS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYepDbSaocoe9wvVz9BieMNYXFi4u+EsrrUIn2Aq13UxE/JnIHZvoaf4ixGrD1Xk8
	 0moEeqY6jNKXEKrT/is9n+/N0ri4TLb69UHOc2fXhi69lyWvrue4eO8v0Hpg0s7pUY
	 fo7oCmSgsuOJ3ZdUftFuPHrHss9AN9CGOpXm1SGmRXuWFUoaYux3QYfte3AugVIDcD
	 7WP/gHJrD+zVxMceAleYSiOmSwnU6IS6W3iCmuzMZ76Py8//piCxNdprCvNnSe86q+
	 xq8/yVWxZFRZ4GNWVqWxJFc1hocmmKgn1YYLLLry72KmcLd4ZeBIeLjjI+7yABQHH0
	 RxZ6GakWJxy4A==
Date: Mon, 4 Nov 2024 12:12:16 +0000
From: Simon Horman <horms@kernel.org>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ieee802154: ca8210: Add missing check for kfifo_alloc()
 in ca8210_probe()
Message-ID: <20241104121216.GD2118587@kernel.org>
References: <20241029182712.318271-1-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029182712.318271-1-keisuke.nishimura@inria.fr>

+ Marcel

On Tue, Oct 29, 2024 at 07:27:12PM +0100, Keisuke Nishimura wrote:
> ca8210_test_interface_init() returns the result of kfifo_alloc(),
> which can be non-zero in case of an error. The caller, ca8210_probe(),
> should check the return value and do error-handling if it fails.
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> ---
>  drivers/net/ieee802154/ca8210.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index e685a7f946f0..753215ebc67c 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -3072,7 +3072,11 @@ static int ca8210_probe(struct spi_device *spi_device)
>  	spi_set_drvdata(priv->spi, priv);
>  	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS)) {
>  		cascoda_api_upstream = ca8210_test_int_driver_write;
> -		ca8210_test_interface_init(priv);
> +		ret = ca8210_test_interface_init(priv);
> +		if (ret) {
> +			dev_crit(&spi_device->dev, "ca8210_test_interface_init failed\n");
> +			goto error;

Hi Nishimura-san,

I see that this will conditionally call kfifo_free().
Is that safe here? And in branches to error above this point?

> +		}
>  	} else {
>  		cascoda_api_upstream = NULL;
>  	}
> -- 
> 2.34.1
> 
> 
