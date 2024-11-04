Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC81C32E2;
	Mon,  4 Nov 2024 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759095; cv=none; b=m12ZWiP6smGaX5Yt1VjI0lOjdM+E9/1Ke/bfFlwFNiNg3EBUPhJS1RCJmQT3MMiVbw6SF0UEYoy3wyFdAJwbvbr5ZNNjqXtur+Bg1vYT8lQs2JUtW5YiCeBmQ7g8srxFEI97PXlD4inG9sg8ooIpvp78/z1YEkPr9uwnos5o9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759095; c=relaxed/simple;
	bh=nff+0X6wUn0J5FjDC8Mc9FUmffHWMVD2NvEYEF5dm8Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uD2oZcROHV4cfpb6nzTHE7jmDxaueyGsiF+6W7rQD6AQvAOjuKdkN2c1H7TKi2L/Ur/AtBjpDfPOkSYmloLXrWMYmUxA1UFd9QPlvDEHNnXr0MUhVYiRTlm/4NepblMUViuUsWqwRFCuj/PQbkuQ4BVKU3sHUmpGSO3NyH9lZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=M8Yuslqw; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="M8Yuslqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5Q/Mzuj7Ex5wTNv3IgObo2Af/emJv/xPYy2+oH55Pz4=;
  b=M8YuslqwooPyRUY165Wt/IgXxfzTy432aWKMJXPg2kcor2duO+VHGI9S
   v29PFXF3r5opWmArMFTiSJpG0ayWzoCwgQsU6fyTBs7U0Kx0D+3fatLAG
   UG/xqJZxNFzbOKjx3yXcsStora0sNkjpjaF00ZRHQzhcNFkZR7Hf5q+S8
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,258,1725314400"; 
   d="scan'208";a="100727236"
Received: from unknown (HELO [10.20.176.70]) ([193.52.24.23])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 23:24:44 +0100
Message-ID: <e004c360-0325-4bab-953d-58376fdbd634@inria.fr>
Date: Mon, 4 Nov 2024 23:24:42 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: Re: [PATCH] ieee802154: ca8210: Add missing check for kfifo_alloc()
 in ca8210_probe()
To: Simon Horman <horms@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
References: <20241029182712.318271-1-keisuke.nishimura@inria.fr>
 <20241104121216.GD2118587@kernel.org>
Content-Language: en-US
In-Reply-To: <20241104121216.GD2118587@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/11/2024 13:12, Simon Horman wrote:
> + Marcel
> 
> On Tue, Oct 29, 2024 at 07:27:12PM +0100, Keisuke Nishimura wrote:
>> ca8210_test_interface_init() returns the result of kfifo_alloc(),
>> which can be non-zero in case of an error. The caller, ca8210_probe(),
>> should check the return value and do error-handling if it fails.
>>
>> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
>> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
>> ---
>>   drivers/net/ieee802154/ca8210.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
>> index e685a7f946f0..753215ebc67c 100644
>> --- a/drivers/net/ieee802154/ca8210.c
>> +++ b/drivers/net/ieee802154/ca8210.c
>> @@ -3072,7 +3072,11 @@ static int ca8210_probe(struct spi_device *spi_device)
>>   	spi_set_drvdata(priv->spi, priv);
>>   	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS)) {
>>   		cascoda_api_upstream = ca8210_test_int_driver_write;
>> -		ca8210_test_interface_init(priv);
>> +		ret = ca8210_test_interface_init(priv);
>> +		if (ret) {
>> +			dev_crit(&spi_device->dev, "ca8210_test_interface_init failed\n");
>> +			goto error;
> 
> Hi Nishimura-san,
> 
> I see that this will conditionally call kfifo_free().
> Is that safe here? And in branches to error above this point?
> 

Hi Horman-san,

Thank you for taking a look at this patch.

> Is that safe here?

Yes, it is safe. The failure of kfifo_alloc(&test->up_fifo,
CA8210_TEST_INT_FIFO_SIZE, GFP_KERNEL) sets test->up_fifo.data to NULL,
and kfifo_free() will then do kfree(test->up_fifo.data) with some minor
clean-up.

> And in branches to error above this point?

Are you referring to the error handling for ieee802154_alloc_hw()? To my
understanding, since spi_get_drvdata() in ca8210_remove() returns NULL
if there's an error, we shouldn’t need to call
ca8210_test_interface_clear(). However, I’m not familiar with this code,
so please correct me if I'm mistaken.

best,
Keisuke

>> +		}
>>   	} else {
>>   		cascoda_api_upstream = NULL;
>>   	}
>> -- 
>> 2.34.1
>>
>>
