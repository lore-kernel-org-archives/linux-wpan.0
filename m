Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFA137E;
	Fri,  8 Nov 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073145; cv=none; b=OE7aH7SwQHg6rWDq8M7jDE3H7Ec2aCCf/qHSOwGb1kXLB9yKOlXt9/4iApwkO/WEPjs/ZUvXfE+wNOc3F6av93gdesOyDF7Vh9Ez0rvAv+xjOY8R0CzFgyeaP9TyqMxUpoRUpOQMlwigKZj0AVhFcZRU/FDQgpwHFyUJ8ojVqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073145; c=relaxed/simple;
	bh=LoopEEbqHEyW8ZSwq/Z6o8eROQTm7q+VQ5PhJOF1F6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsyD0NTr4Bfzk5VjuEkxfDuXT3jQr4k5TRZp4eh24lkVRG9upDc7Ul86YBFnerZ/THGgWoduzB2J8WB2RtsTrcC6hYSVbSEcWVr0GH4yNXdr76WjbRD/v7NMM7azRKX9RrYnrnDnEUDSHo20qlfac9IX4LqvCC+Hbz7AFHp/++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl28hSsx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl28hSsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA61C4CECD;
	Fri,  8 Nov 2024 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073145;
	bh=LoopEEbqHEyW8ZSwq/Z6o8eROQTm7q+VQ5PhJOF1F6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl28hSsxa+EONk2bHdCFzkxp/9qRGmx2MYq16LuIyfnvVXbCvSt2262GEEv6mcIbs
	 VqaJESQ6KkdE2yekEY4LoFpXOW0t3B59C49PXdd0wmrIDoBc2sCNqKoXmVPw/zYEsA
	 dWtj5KdMavALXZKuGF7KCiPnYgQYIp9yLOdGQhbLiH3STUyap4r3m8r7FmouLKGCUH
	 EiG/8U8BGdI8NPb8aBHtI1M+zwRpvf9Kqgn5UGrq69J+WlFFFz0QMA5v5AWVkbxLYO
	 gBN5WQC2rvPrevN17jswaxAS1RN+OFMRI95rL4tVogpUc86rVSBv+JMHT8mYB2/7Wu
	 5XdQCoPH2LoTg==
Date: Fri, 8 Nov 2024 13:39:01 +0000
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
Message-ID: <20241108133901.GD4507@kernel.org>
References: <20241029182712.318271-1-keisuke.nishimura@inria.fr>
 <20241104121216.GD2118587@kernel.org>
 <e004c360-0325-4bab-953d-58376fdbd634@inria.fr>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e004c360-0325-4bab-953d-58376fdbd634@inria.fr>

On Mon, Nov 04, 2024 at 11:24:42PM +0100, Keisuke Nishimura wrote:
> 
> 
> On 04/11/2024 13:12, Simon Horman wrote:
> > + Marcel
> > 
> > On Tue, Oct 29, 2024 at 07:27:12PM +0100, Keisuke Nishimura wrote:
> >> ca8210_test_interface_init() returns the result of kfifo_alloc(),
> >> which can be non-zero in case of an error. The caller, ca8210_probe(),
> >> should check the return value and do error-handling if it fails.
> >>
> >> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> >> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> >> ---
> >>   drivers/net/ieee802154/ca8210.c | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> >> index e685a7f946f0..753215ebc67c 100644
> >> --- a/drivers/net/ieee802154/ca8210.c
> >> +++ b/drivers/net/ieee802154/ca8210.c
> >> @@ -3072,7 +3072,11 @@ static int ca8210_probe(struct spi_device *spi_device)
> >>   	spi_set_drvdata(priv->spi, priv);
> >>   	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS)) {
> >>   		cascoda_api_upstream = ca8210_test_int_driver_write;
> >> -		ca8210_test_interface_init(priv);
> >> +		ret = ca8210_test_interface_init(priv);
> >> +		if (ret) {
> >> +			dev_crit(&spi_device->dev, "ca8210_test_interface_init failed\n");
> >> +			goto error;
> > 
> > Hi Nishimura-san,
> > 
> > I see that this will conditionally call kfifo_free().
> > Is that safe here? And in branches to error above this point?
> > 
> 
> Hi Horman-san,
> 
> Thank you for taking a look at this patch.
> 
> > Is that safe here?
> 
> Yes, it is safe. The failure of kfifo_alloc(&test->up_fifo,
> CA8210_TEST_INT_FIFO_SIZE, GFP_KERNEL) sets test->up_fifo.data to NULL,
> and kfifo_free() will then do kfree(test->up_fifo.data) with some minor
> clean-up.

Thanks, sounds good.

> > And in branches to error above this point?
> 
> Are you referring to the error handling for ieee802154_alloc_hw()?

Yes.

> To my
> understanding, since spi_get_drvdata() in ca8210_remove() returns NULL
> if there's an error, we shouldn’t need to call
> ca8210_test_interface_clear(). However, I’m not familiar with this code,
> so please correct me if I'm mistaken.

That makes two of us. But I don't think your patch changes this situation.
And it does improve things wrt to the problem described in your commit
message. So, while I think it would be worth looking into the error
handling for ieee802154_alloc_hw() I don't think it needs to block progress
of this patch.

Reviewed-by: Simon Horman <horms@kernel.org>
