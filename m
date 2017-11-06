Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:42016 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbdKFPdf (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 6 Nov 2017 10:33:35 -0500
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH 09/14] ieee802154: ca8210: fix some kernel coding style
 errors
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-10-stefan@osg.samsung.com>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <45ebe3d4-3e4e-7eee-e989-1aec0935c4e5@cascoda.com>
Date: Mon, 6 Nov 2017 15:27:52 +0000
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-10-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, varkabhadram@gmail.com, alan@signal11.us

On 22/09/2017 13:14, Stefan Schmidt wrote:
> Remove unneeded parentheses and fix format for pointer style.
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   drivers/net/ieee802154/ca8210.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 24a1eabbbc9d..66829055aa8b 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1303,7 +1303,7 @@ static u8 tdme_checkpibattribute(
>   		break;
>   	/* MAC */
>   	case MAC_BATT_LIFE_EXT_PERIODS:
> -		if ((value < 6) || (value > 41))
> +		if (value < 6 || value > 41)
>   			status = MAC_INVALID_PARAMETER;
>   		break;
>   	case MAC_BEACON_PAYLOAD:
> @@ -1319,7 +1319,7 @@ static u8 tdme_checkpibattribute(
>   			status = MAC_INVALID_PARAMETER;
>   		break;
>   	case MAC_MAX_BE:
> -		if ((value < 3) || (value > 8))
> +		if (value < 3 || value > 8)
>   			status = MAC_INVALID_PARAMETER;
>   		break;
>   	case MAC_MAX_CSMA_BACKOFFS:
> @@ -1335,7 +1335,7 @@ static u8 tdme_checkpibattribute(
>   			status = MAC_INVALID_PARAMETER;
>   		break;
>   	case MAC_RESPONSE_WAIT_TIME:
> -		if ((value < 2) || (value > 64))
> +		if (value < 2 || value > 64)
>   			status = MAC_INVALID_PARAMETER;
>   		break;
>   	case MAC_SUPERFRAME_ORDER:
> @@ -1511,7 +1511,7 @@ static u8 mcps_data_request(
>   	psec = (struct secspec *)(command.pdata.data_req.msdu + msdu_length);
>   	command.length = sizeof(struct mcps_data_request_pset) -
>   		MAX_DATA_SIZE + msdu_length;
> -	if (!security || (security->security_level == 0)) {
> +	if (!security || security->security_level == 0) {
>   		psec->security_level = 0;
>   		command.length += 1;
>   	} else {
> @@ -1561,7 +1561,7 @@ static u8 mlme_reset_request_sync(
>   	status = response.pdata.status;
>   
>   	/* reset COORD Bit for Channel Filtering as Coordinator */
> -	if (CA8210_MAC_WORKAROUNDS && set_default_pib && (!status)) {
> +	if (CA8210_MAC_WORKAROUNDS && set_default_pib && !status) {
>   		status = tdme_setsfr_request_sync(
>   			0,
>   			CA8210_SFR_MACCON,
> @@ -2369,7 +2369,7 @@ static int ca8210_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
>   		MAC_PROMISCUOUS_MODE,
>   		0,
>   		1,
> -		(const void*)&on,
> +		(const void *)&on,
>   		priv->spi
>   	);
>   	if (status) {

Acked-by: Harry Morris <h.morris@cascoda.com>
