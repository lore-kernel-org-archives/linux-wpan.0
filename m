Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00F4DEC07
	for <linux-wpan@vger.kernel.org>; Tue, 22 Sep 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070461; cv=none; b=qK/+eiE3DAjyERAkKLfoV+AjjR+kANyAWZ5p2NtLuwHk03oAQbkgRm5B2/nxPsKIfTsyIbg8uh5LW9bYxmW3QXjNGXidJYALI3IYloH+E0JR7rVPAdf2mpRWesb0KdIVhPtjKZjU2TYY6j0XSvMzhWJNomeUF41u8HhLoJByHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070461; c=relaxed/simple;
	bh=2CUH3YGiPlXy555Q9SI3ZYnCZbH8YDJQaUSBvfvqZ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rfyv77v3l0thOtGykaNoH1n8vSISsmTCpu8JNfacp103JYoERiTZTg/QG10jEMRNff8k0gnG/oD2ZpFDgDAXnVjk4LDEWpOfPV/iE4OEzTXqbssAQE2Ne/cZXzkY8J6CpiiHdM4z1iFdSpzp9QnUuQ0oKsoFK2EwgYArdp2CVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvNBStGl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvNBStGl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd80so1873359f8f.2
        for <linux-wpan@vger.kernel.org>; Tue, 22 Sep 2026 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790070458; x=1790675258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mHA714llFxRbL4YpV3zzI7qdHUQEj56NbS4Oyhz2TE=;
        b=UvNBStGlptbsfoizP0M7WPR8TBH+UhYLVyjoEPDRLeSoLNQuh7GLHz3T5/m0+UmBNZ
         RHrrzsLV0K/1tL1nA+hHnjigNFBMWMqOHkC2hAp9rehOuAlFe8SvIs8Z6CpW3d6rTbbu
         qUN4yFety6ERn2Pq27SISc97Qgyi/FNkA/2oV0hESNH3CrGFm1JB7EYRbfKMluJjr8oK
         ttR4FN9+EvyTCRmk7aGWOVeyliElH3Fme+P3KYATNqyFatLBn3k0NH1gwluMVxzIirTx
         DTowTIQwxpjvhHhSZOLcG5y2+hQWEt9qDuVNyafBzvAUvmydtwW4n5iPhqIUqR/Rgbej
         XPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070458; x=1790675258;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mHA714llFxRbL4YpV3zzI7qdHUQEj56NbS4Oyhz2TE=;
        b=OnrU4cH1k09TR56g2pNe4jFhoBLEhmYtlS+m6ei4zh5Wi3xzJ7La58+nrh+i8WvPdg
         NLeOXB6dJDw+a00fHFL0+VFyQ6z/F7DKhnZSZs2TRfYPoFNor/rF750uI9N493CbEy2B
         Kb54hcawrgHxFpCfuOCj6QRf4EwuZP94U5lz3rbEwQ1LCLZZWPaiBb7aNB+HQsX33FUs
         8pyBjRiMHbLP/4QfpcR2oxBAn5SU3qRchRDaRmSAdM7Zw6yLE9XfnIx+3Wicldp4dGVH
         RSiNUjX/s2ZX8NSw2pegKHqzFApgL+Xex8Jjc5ipnl7cI8Z2Tu0xF6/DZk9fyfKIb+N4
         Fvpg==
X-Forwarded-Encrypted: i=1; AKwUvBypcysJyRKSGz2YgAsdshhjJRF9Sq4TcHqFOKy32Fgx9sDgzWfmeCZ77bo77P0lgoLxpIy4ULVJ9O+m@vger.kernel.org
X-Gm-Message-State: AFuF++lhbOHw9Ml56ieaouyeAnaAK1cCbxJfXa7sIXW321Qg1up3wqeT
	bp6j3P3kez+2LpFifOzlaMYXgy2njTmbds9/ARmPb/ubyFLJpTcfACb0
X-Gm-Gg: AYBFou2hZfTuWwC6qQpoOkiUeWOlCHNWOyQRaGxF47gR6HBwEjr9bGuBDqCYvLF2hf8
	2lAS+2U2HQvHv85Uwlk0FXhP5c/Ndou4W+u0P1KB+S9brECXIAYw940BdwZbCibHji9Yl0AWNCE
	cB0a+WKH5DIFNnqoGLIDO9kmxtbInz2NEwVMhQYZ/NoAtOxNdVR6BTi32ixtnUzS7xLgl9D29Xf
	hePmKjIeO/AJHSNkeojm97IMrQWSQam+ZgfV2Wujrb9ug14Ktb+7XWcw6N3zU8LdbyfVUXJS5hP
	BRmV6URo7wiI1DYeNYgFCABIdM4j8BP1IA3xemeHrz1t/KV1ZNtv9GCqxxFaSCYHYdXrNk/Qefa
	iMd9WvdeciUrxyPlCjmAubsZkZ70wIpFJR2gatcWb5YU+/fxWEH9YxFMxp9mp8FgVZALDz14qIO
	gwOsvuCAhHepCOZ4zgEJNKUTdTeGJdx8KJ3no7SRa9J9OydL9Lc/4GK1xsf2Kje9aDy6e3Grtxd
	jP/ErCyaISwclneEeynaFGOQOAKRYtnXxw=
X-Received: by 2002:a05:6000:1a8a:b0:487:62d:37dc with SMTP id ffacd0b85a97d-4871e269cd3mr21320913f8f.32.1790070457566;
        Tue, 22 Sep 2026 02:47:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862773ee0sm3708938f8f.6.2026.09.22.02.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:47:37 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:47:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Harry Morris <h.morris@cascoda.com>, Alexander Aring
 <alex.aring@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
Message-ID: <20260922104736.0e7e20f2@pumpkin>
In-Reply-To: <20260922093126.141969-3-benquike@gmail.com>
References: <20260922093126.141969-1-benquike@gmail.com>
	<20260922093126.141969-3-benquike@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 09:30:24 +0000
Hui Peng <benquike@gmail.com> wrote:

> In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
> stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
> unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
> bytes into hw_attribute_value without checking the caller's destination
> buffer capacity, overflowing level on the stack when hw_attribute_length
> exceeds 1:
> 
>   BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>   Write of size 16 at addr ffff888001907780 by task init/1
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x70/0xa0
>    print_report+0x153/0x4c6
>    kasan_report+0xf1/0x120
>    kasan_check_range+0x125/0x200
>    __asan_memcpy+0x3c/0x60
>    hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>    ca8210_get_ed+0x9c/0xf0
>   ...
>   The buggy address belongs to stack of task init/1
>    and is located at offset 48 in frame:
>    ca8210_get_ed+0x0/0xf0
>   This frame has 2 objects:
>    [48, 49) 'level'
>    [64, 65) 'lenvar'
> 
> Initialize lenvar = 1 in ca8210_get_ed() and return
> IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
> response.pdata.hwme_get_cnf.hw_attribute_length exceeds
> *hw_attribute_length.

This function is silly.
There is exactly one caller, the only valid length seems to 1 (is zero valid?),
not much point using memcpy() either.

David

> 
> Tested in QEMU with KASAN enabled by passing an oversized
> hw_attribute_length response into ca8210_get_ed().
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v3:
> - No changes.
> 
> Changes in v2:
> - Split out as patch 2/3.
> - Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
>   and an upper-bound check against *hw_attribute_length in
>   hwme_get_request_sync() as requested by Miquel Raynal.
> 
>  drivers/net/ieee802154/ca8210.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index a990a0f..8aa7ffe 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
>  		return IEEE802154_SYSTEM_ERROR;
>  
>  	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
> +		if (response.pdata.hwme_get_cnf.hw_attribute_length >
> +		    *hw_attribute_length)
> +			return IEEE802154_SYSTEM_ERROR;
>  		*hw_attribute_length =
>  			response.pdata.hwme_get_cnf.hw_attribute_length;
>  		memcpy(
> @@ -2027,7 +2030,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>   */
>  static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
>  {
> -	u8 lenvar;
> +	u8 lenvar = 1;
>  	struct ca8210_priv *priv = hw->priv;
>  
>  	return link_to_linux_err(

