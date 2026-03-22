Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997128642B;
	Sun, 22 Mar 2026 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219048; cv=none; b=Pb9vs7J9pU9FTnfq5B1Qs5qaoZzSI/4o2QLZx6nkpkqEH9DDbg8QUTOCeKatnLovbPsmQMRwJVCYqo5jPHBrowBzH6t4wkYiAhc0mgu3D7ipztrx4prZNabDB+8hvNb5RZiSGTs+ydKq2/Z/iNslZY2ohqNOBa9u9DVebY+kkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219048; c=relaxed/simple;
	bh=cwKmKrBehC3eWBWOV3D0RnsdYcHGCiY95lRhCPL4k3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCG9ik5h1gNUukEf0qQsCwDzVlqqK1l7gQYabvgqaD1gJ8p+Wlzswpmc0PcLQ7hMw46AyBcGg7eyd204EQwdZyNWQN0bKgMU5FUTee7C77kB6xiNOkWJrvtWcdKt8fw1wRg1UUZ126UEj3GDwQDmyfvDHHKUo5QZnxO3d3fFZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=ft3da00d; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="ft3da00d"
Received: from [192.168.2.30] (unknown [46.253.254.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id E13F7C034C;
	Sun, 22 Mar 2026 23:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1774218449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiyTyEMNWezsYXPnf+/PmiVO+I71O3ORqcsuAzMGM1I=;
	b=ft3da00d0+Jx1/+K0qK35iI/nGqO8WHdj0xhmD2eJhkfjHtv04IKhO745eY3TfhUpMDZCz
	Zkx6zhQcUkdoWqkKBr82wzFmvf51ZDisAKGIH9nr6STTMOTrbFxLuG924X7iBshE3dgCIO
	h4xjTmOly5Kz5wSPmHTtE+GJe0MxW32sA5niBPeDhR35CVVWYBGjQGkyT2whWyN/IjOiZq
	sFa5ceZCkfLF057Rs+UGTpHrXh5xdlFTeeN4pg61ZeN+5H/2kULg5u33TIfHFJjLEbdFRM
	GLHQbras/8OrxIwtgWbDVBu3KkTH8GR2njDjTdEoM5kmLDJcSDR+dmWQx/5lhg==
Message-ID: <d71db3f0-12b0-485b-afec-ea5eeed35305@datenfreihafen.org>
Date: Sun, 22 Mar 2026 23:27:27 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ieee802154: atusb: drop redundant device reference
To: Johan Hovold <johan@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260305104313.15898-1-johan@kernel.org>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Content-Language: en-US
In-Reply-To: <20260305104313.15898-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 3/5/26 11:43, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/net/ieee802154/atusb.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 95a4a3cdc8a4..5f7fc4ee7a07 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -961,7 +961,7 @@ static int atusb_probe(struct usb_interface *interface,
>   
>   	atusb = hw->priv;
>   	atusb->hw = hw;
> -	atusb->usb_dev = usb_get_dev(usb_dev);
> +	atusb->usb_dev = usb_dev;
>   	usb_set_intfdata(interface, atusb);
>   
>   	atusb->shutdown = 0;
> @@ -1055,7 +1055,6 @@ static int atusb_probe(struct usb_interface *interface,
>   	atusb_free_urbs(atusb);
>   	usb_kill_urb(atusb->tx_urb);
>   	usb_free_urb(atusb->tx_urb);
> -	usb_put_dev(usb_dev);
>   	ieee802154_free_hw(hw);
>   	return ret;
>   }
> @@ -1076,8 +1075,6 @@ static void atusb_disconnect(struct usb_interface *interface)
>   
>   	ieee802154_unregister_hw(atusb->hw);
>   
> -	usb_put_dev(atusb->usb_dev);
> -
>   	ieee802154_free_hw(atusb->hw);
>   
>   	usb_set_intfdata(interface, NULL);

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Jakub, Dave or Paolo can you folks please pick this up into net-next? I 
waited a moment but I have nothing else for wpan-next in the queue for 
now, so it would be silly to have a pull-request just for this.

regards
Stefan Schmidt
