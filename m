Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D51F4174
	for <linux-wpan@vger.kernel.org>; Tue, 27 May 2025 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329361; cv=none; b=JQ5d6+KJZVafQF06KME/+vGQeEROIryZth0sJ5FqO/F2YsCzM70oiBZllOBdjb1FKln8ltoMn581+2Ydcp0ESMd/PASwdpYa8HO2kiiimTmBrnuyotM4qJh6IZV09QRNVecK+1SVT5SgtY3sH+PZdITg/MoZ8sdnFjhOIkH7XO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329361; c=relaxed/simple;
	bh=uerM567QcQCVqLcNbyZwn68Uozgpe9FXmx2lyhpHDvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOz74JHhT/XpbE5fdCQ+tUEJZc+muEUKgg6DgV2u1xW6j5GKlgZYr0ARcXViHCVjCDjlqOcJWiLjvMjiJLLr8kXnsmVpLCAGb8UX3x/t+UB/uPcIF1D0Zq4/lgC0miv/wzcKEa5mxjS54LSAe2BhMi/i/y7qpBZu6x7tLzSyqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yi4dtCcf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi4dtCcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748329358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
	b=Yi4dtCcf+bzMTess/9cd0O1keZtHM/VSd5wGkglld6w41j+37osuioI1u1JYegBohXH+Tr
	MWhOIASd/ULT+e3Di4pDa7FAAEfMOTIL69v5ghtyUOgiOkG4kVW/TpbxgcwRDf8zwn8gJ+
	8XVZs0OUCuihB5n9uy0TxRDJgrJA1jo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1BGGlFhDPLuBFCP1uJqh0A-1; Tue, 27 May 2025 03:02:34 -0400
X-MC-Unique: 1BGGlFhDPLuBFCP1uJqh0A-1
X-Mimecast-MFC-AGG-ID: 1BGGlFhDPLuBFCP1uJqh0A_1748329354
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3561206b3so1238244f8f.2
        for <linux-wpan@vger.kernel.org>; Tue, 27 May 2025 00:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329353; x=1748934153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
        b=q185ISwq7iBjw92fPKRlDPnEVEWwuvSPhMUje2d06cKlErTGnsAzFtZE0u099JFPeN
         MiUBI9ZoSLMagf0fUvvU/eYIo3kfOp6oovrLR3GbnGnMuucPTSVsC83J8k1Jmsi4acGb
         Q9vXvC/GNuUC1tP1ZBzhSo6cMns0hlAFbaqP76qdivMkBWhaZ6vu3u+bfHrncZevrDIE
         wWP5RL7BSPijSaxMLufLM6k8L6uErz4GKMp/+7Mhl29b/HVisV2zLrgfupnmse91beEp
         jeUphMz+EQD5DyA89bEzHIWwvTz43/5k80bDmj0kmFzj9eru9X+L94I/gjHaPrLOigjW
         sOrw==
X-Forwarded-Encrypted: i=1; AJvYcCXes/pUYGbFYHA64Q//GN3eC/0Vwp6v/E1q6XZezzDgJI1DhOxOkmlvR9yfoJ9Jmba/qA9PYjRdxYj2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbjm3gr0TVHCSHZEG4P0XfQuH6MAiL/KJa/rkMisj39mp799s5
	bMWnR887BUfWwb0ePvFTt65xH9nz50h8c6lXb1FETe64wgbqBQSNK/px30EkRLXDk1BDoLzTfIR
	xbXq798kY1oJn8pRT7IL2FqpS04Epj4S0Rg3X/43fK7AHUEOknkYuDY7O4IOQ+WA=
X-Gm-Gg: ASbGncvVXSqfHzqklYO95rZNAIOkquGshEQDjbbLi4UK4w6VWiS6i1m+X9ZPMdLndbZ
	5a7v2q5uYHizQQ6t6XqmRpnNTQ0NUNCx5Og599GdzT4rgm+q3HCZqXbggfH/lu2prgtGM2XCX9f
	vhkLImY3Nq3qv7Si2CN1nrDlM2OOZzj1aaEgHxN2k/UWzYxoYON2Yd6kg6gdZll8oftBIe0/qgG
	DNBC3zCjGA2ymPzBVuKwc+yMv3WDXSzGIjXjnOSg6Lg+7iM9qhbEejCSWhTHrUckwJkmtsqIUKX
	uEpOV/ItZzdH2QWMpCKCpsUNFIvArrRmT6sKCGXH904b3MwQPmK9bWf7V6k=
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608654f8f.57.1748329353548;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGex5mHhM/OYaq2gRKUAD/HxHUJY3MptMrHBU8jm/eQhY8uxpjEvS25/QUCzUXZRuezIVGAwQ==
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608571f8f.57.1748329353087;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cc52ab88sm9930473f8f.11.2025.05.27.00.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:02:32 -0700 (PDT)
Message-ID: <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>
Date: Tue, 27 May 2025 09:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: core: Convert
 dev_set_mac_address_user() to use struct sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Maxim Georgiev
 <glipus@gmail.com>, netdev@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Lei Yang
 <leiyang@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Hayes Wang
 <hayeswang@realtek.com>, Douglas Anderson <dianders@chromium.org>,
 Grant Grundler <grundler@chromium.org>, Jay Vosburgh <jv@jvosburgh.net>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Philipp Hahn <phahn-oss@avm.de>,
 Eric Biggers <ebiggers@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250521204310.it.500-kees@kernel.org>
 <20250521204619.2301870-8-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250521204619.2301870-8-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 10:46 PM, Kees Cook wrote:
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index fff13a8b48f1..616479e71466 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
>  		return dev_set_mtu(dev, ifr->ifr_mtu);
>  
>  	case SIOCSIFHWADDR:
> -		if (dev->addr_len > sizeof(struct sockaddr))
> +		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
>  			return -EINVAL;
> -		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
> +		return dev_set_mac_address_user(dev,
> +						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
> +						NULL);

Side note for a possible follow-up: the above pattern is repeated a
couple of times: IMHO consolidating it into an helper would be nice.
Also such helper could/should explicitly convert ifr->ifr_hwaddr to
sockaddr_storage and avoid the cast.

/P

