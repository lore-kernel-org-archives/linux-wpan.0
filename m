Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:43741 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbeC2PZq (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 29 Mar 2018 11:25:46 -0400
Subject: Re: [PATCH v2 1/1] ieee802154: ca8210: fix uninitialised data read
References: <20180328105427.34812-1-h.morris@cascoda.com>
 <20180328105427.34812-2-h.morris@cascoda.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <ccbb2034-90e6-e10b-b4d1-d028042733ce@osg.samsung.com>
Date: Thu, 29 Mar 2018 17:25:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180328105427.34812-2-h.morris@cascoda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com, linux-wpan@vger.kernel.org
Cc: aring@mojatatu.com, domen.puncer@samsung.com, Harry Morris <h.morris@cascoda.com>

Hello.


On 03/28/2018 12:54 PM, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
>
> In ca8210_test_int_user_write() a user can request the transfer of a
> frame with a length field (command.length) that is longer than the
> actual buffer provided (len). In this scenario the driver will copy
> the buffer contents into the uninitialised command[] buffer, then
> transfer <data.length> bytes over the SPI even though only <len> bytes
> had been populated, potentially leaking sensitive kernel memory.
>
> Also the first 6 bytes of the command buffer must be initialised in case
> a malformed, short packet is written and the uninitialised bytes are
> read in ca8210_test_check_upstream.
>
> Reported-by: Domen Puncer Kugler <domen.puncer@samsung.com>
> Signed-off-by: Harry Morris <h.morris@cascoda.com>
> Tested-by: Harry Morris <h.morris@cascoda.com>
> ---
>  drivers/net/ieee802154/ca8210.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 377af43b8..58299fb66 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -2493,13 +2493,14 @@ static ssize_t ca8210_test_int_user_write(
>  	struct ca8210_priv *priv = filp->private_data;
>  	u8 command[CA8210_SPI_BUF_SIZE];
>  
> -	if (len > CA8210_SPI_BUF_SIZE) {
> +	memset(command, SPI_IDLE, 6);
> +	if (len > CA8210_SPI_BUF_SIZE || len < 2) {
>  		dev_warn(
>  			&priv->spi->dev,
> -			"userspace requested erroneously long write (%zu)\n",
> +			"userspace requested erroneous write length (%zu)\n",
>  			len
>  		);
> -		return -EMSGSIZE;
> +		return -EBADE;
>  	}
>  
>  	ret = copy_from_user(command, in_buf, len);
> @@ -2511,6 +2512,13 @@ static ssize_t ca8210_test_int_user_write(
>  		);
>  		return -EIO;
>  	}
> +	if (len != command[1] + 2) {
> +		dev_err(
> +			&priv->spi->dev,
> +			"write len does not match packet length field\n"
> +		);
> +		return -EBADE;
> +	}
>  
>  	ret = ca8210_test_check_upstream(command, priv->spi);
>  	if (ret == 0) {

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
