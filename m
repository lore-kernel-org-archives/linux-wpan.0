Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BE390C95
	for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166036; cv=none; b=h0ANfaDk0y7swUwpAGA68mi3r0/qhSpmeGkwawDb4XWyQ46HCOsS614oIGSnk4+oMVqBByYfNtFatSdDdTNJ/JLy+33vJywljVWSP24MiFPMZYxy6Oty8ROyWfKJtOxtQbcgYI85YWjmZ4pa/gjPyAdZdXoUPZPVCIbO5z8i72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166036; c=relaxed/simple;
	bh=1XeOmQjiCmitTcAp2U7m3O2xukG+U0k4mys23LN33m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+eqg5qLql96FV7nVI8jRL/VUk+ZjZlRC97Oc96x6vI3DJ7kjBXa7tkMiUBxo+AKSc5gaihQcnYXGtZHUgnA1Ois1ZtPFbWqF7NoJiZi89569zpK77b3mX3vq+k7gZ1NlXo4zEUp4NJkyQn8gRbm4I4EiPy5KWMbI3QpVWkdlfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDdCgNVt; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDdCgNVt"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so949738a12.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166034; x=1785770834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PA2a81BeXH83G/BeP/kggUZUVWwJJJOgGGWCxqitXXc=;
        b=XDdCgNVtCzEAe4yqWh+ezwqETD7BGhvrYizMdhpblNwmZRah5lPcDCT4JAmYrLyDJS
         gi+ESZzsTA13ceDM+gHnIaUNPlQuyZhSUZx8DMJEV0hCtsWtdLSxCGI2CTf4kGBHWumQ
         mbjp4BbzDqNWx8wY+s5pW8UvEXIlAY9C1Bbhxdo71h6kBDOhVEbqUJqOlsAVLxGSB+X1
         zO/VJ6Sf3+LpM3IggwbKekKkhAqgsmc9zif2NT4+Ds/2C7t4OVUG8BVuAooF8UhVL9oO
         eueQO7QcvPz2qaG4aYDdC/aV1W3W0JV6Nrldt55gj+iGNa0KNWSKkYQE7xm4ucKowKJm
         DA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166034; x=1785770834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PA2a81BeXH83G/BeP/kggUZUVWwJJJOgGGWCxqitXXc=;
        b=elECHVn6s3hdNUlqeYeiTLhF9YES9977QnSuZbNr20P8LIMqCHlt+eHaVxZaXT68HX
         U3BxdNt4s6INMVRn2D0R2HnrjK8x9FNQgZpXGh3ihBn0+QpHX8SfLnb0oIUYuzh7xTQB
         VijHFWacitWxg396AigSj0rl2ouY1NZA+SAWWpmI9HEaLQ4gOXQBODdJF9C3aQrwAYEG
         h2uUoTf7OIasL8f4BnuoNtYOq4ekMUadj3XDHN+0z6bs4Jbz3RYo/I2elGnWLwezWm/K
         75vovc+8UDgVl1Gxt4ub2bOrqnrx0yULUUXiiyMe6Kp5TG0UTywtwQurGhQbRgXmktih
         M0bA==
X-Forwarded-Encrypted: i=1; AHgh+Rrwe1ZJbbh3hiMA/At3CmWUr1V87dIWTdl6STpXow8HiV/RzTcqlCcY0IGeYOy08B7Cjj30l3AXfQJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mwWP9pglYjcbObQ2IckpzqDDmlrGQS8H/DZB6i8tcmGmJYMn
	v291fFdwOX4wUA5RpTKEvXz4OXVc1+9Bty1Bw6ECoiF3PrnU33saPVWu
X-Gm-Gg: AR+sD13u+GbWt4dQzmXHXfu3S3NL8KjR8nqv43CfRbLWwtNDxK9ZF3L+1w/4000EM0w
	O1b2QBNg4ATPXYuYEBtTWAe6Xsl3dTh+GQRZ2IXh0HWLe2TXSPdtj3fnOdxiJ2+g17dWwVwBZoX
	fwFBbXDcWZUth/UIotYYGW0rdt1wpynHrZCVhAuvenId3GBDW6E4DrtWyWGHGrGOikMnytPbdSG
	QXuUTX+95pSFm1L5wirZ1yTPaHFXFGwwbJjscgFeNAPchlKryv6JuV432U8aWzPU24GYgYg1HAW
	YZGoIt2sfUv7VVE8pPZg4R+Ac2oSybmdsNchwPOzGaqKr33bO873XhjDPf+XlLSHETH4xXctdPR
	yGAdjRil1C3UR2iZFgLFBY8X/uDv+01E0be3oC+5wBElvXt1rB/Y/wvDzzeKdmu/q1cMDvFU=
X-Received: by 2002:a05:6a00:8018:b0:848:41e1:473c with SMTP id d2e1a72fcca58-84e595d13afmr7024673b3a.72.1785166033675;
        Mon, 27 Jul 2026 08:27:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b2cc2sm3364331a12.17.2026.07.27.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:13 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:26:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: getsockopt_iter: cover
 rawv6, ieee802154, phonet and tls
Message-ID: <amd4ka3u1X80rQsZ@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> Add fixtures for the newly converted getsockopt leaves:
> 
>   - rawv6:      IPV6_HDRINCL / IPV6_CHECKSUM int paths + a SOL_RAW
>                 unknown-optname case that reaches do_rawv6_getsockopt().
>   - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
>                 rejection.
>   - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
>                 rejection.
>   - tls:        TLS_TX_ZEROCOPY_RO, the TLS_TX crypto_info round-trip at
>                 the base and full cipher sizes, the NULL-optval and short
>                 buffer EINVAL paths, and an unknown optname. It skips when
>                 the kernel lacks TLS or AES-GCM.
> 
> Each fixture pins the returned-length / errno semantics across exact,
> oversized and short buffers, an unknown optname and a bogus level. The
> semantics are unchanged by the sockopt_t conversion, so the tests pass
> both before and after the leaf conversions.
> 
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
