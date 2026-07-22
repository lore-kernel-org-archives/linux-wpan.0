Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B567339383
	for <linux-wpan@vger.kernel.org>; Wed, 22 Jul 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727639; cv=none; b=L632tRQQllMpfkc6hDpgqpuPzI1Srg72w2oiNEcXKRpRX064kMOgSnSDP2fcCj3qtbZzYOx8Ac+2LBFep90Iw/YMcFhq18yudj96QUeEs2qLv7aQZpzFDJCzv88zkdQVBtFmNzl9RBvpqOmTmYx91EctRZhwEc+NyRBjvO/p2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727639; c=relaxed/simple;
	bh=gui0VHTSLLwEHTPJ7tc1ugqJNcqEWciy6Fvv6kb8FpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG0hikuiUSTZMOrToB4FE4wJGOWvyug/jpA6jsDqc5JblBaF7ZjtofLuvyxZpP9mBd4LeHuDVGQWUbrp18Lpq6OnHzrgrSrJhTO+wEl+UI3S/ZLHMk4OaUjqhIemaE4TPnkH3lWBS4rvzUj1PPJMzObK9BKWA/7xho8wk+c3JfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ftS+fLD0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ftS+fLD0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso9215363a91.3
        for <linux-wpan@vger.kernel.org>; Wed, 22 Jul 2026 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784727636; x=1785332436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9feiKeFcTEnJsnOt+AVgxkROZ++OwVZ0S00dQJw9vl8=;
        b=ftS+fLD0qv/usuDVM+ESN4XKOBsoTKL2Df1skMTcrKJpPs/FYnGILEECIUyN4Y0dmJ
         hSAdny02ZivrrvoI1DRt+zq4G7RKhWYAC+zQsHGBJI5RJ7cCeKv+djO/MItHWvbRloR4
         T7y8A8oxGiY4z7xW/njiWXG+OekQH2kFNYnUWVNcZOrJvCiP0ik4dUPJVl+7l/ReGaLh
         cJ6axA5npjVn5KXrA7GtBVQsRiol13yVhAWEMoQb/hyTN52XgiHHre96VwRBSBU7IMwB
         oVul2VZqDOWUDGAEG96NPQseqNkl5C/+LNvt4iCPVmJ5vwVAJE9IxyPoPJ3W4wXpNxBx
         oG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727636; x=1785332436;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9feiKeFcTEnJsnOt+AVgxkROZ++OwVZ0S00dQJw9vl8=;
        b=CHsJUl1r2pY/LnEJe+NfCL0cXL3tQuWf9x9yAe8LrfxZ7cBufC8pnaT11nbvW5oLSe
         PCqs6pBrqAsnIr8QQYoatzDLOkVJtuWTdkrbQ4D/ZJgnQeTCo6kb6coPK8H59lgUyG/c
         /scTwH/2GLpKSe8lG+A8IMWNKL5cOws0TVRAOLUkU5aCNF/PG+Q6xTuj4BOchcoHJLT3
         3o5Xl4OH49x+bVbd0lkheF5/Ocri9oxiAVIjNl9Jej0fyvBKY01wzSiMXTbO7GTx6jIu
         SHyhL8TsEN4F2BlBnPWpG6am2Ttq0C/mtcSHXtYF3/czEF/wgfBWY2MkphlzbAA4OKKX
         kORw==
X-Forwarded-Encrypted: i=1; AHgh+RpfUnPjXPx/Z79PnU91G7n7LAmhPP1UIM+MINOaxAgXlrhKsU+ilhOqJ5KHnCntFLSrMzvset0cLsf0@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7sP/q7IJRXcaWui7hlYZjMB8Th+/6jJNZuRIFxYYLTjbbidc
	7kzPuLoH4wwbxQCuQc5wR8SOqi90kVGJzFvUkyFnpZf5ciS4dygcHAAYYZe9tUjL5D8=
X-Gm-Gg: AR+sD11xBzYAKCyb+Pd8F85wPC4TK6B23bhxbMuK7ozbq2RxJnLz4KcS1X+22Sxw1EZ
	23QUz60doyD0GGnJz3+L32AlB2R6NS2yIVXzlEVYhm3pi4j+BtjnAc/SkANHB51nTe7gRtxK7fi
	eDHpK5RaA1dxhMKOih8GvWq6uux+N4aKd6+evHPR7QysSKIGUAinJuQCBdTFuFRNltmNT8V15UZ
	IYeQtu6e+GDvkrb/gU3Ao6YrlCD+gAfeyUCil3GBYufTv0k17jGhlT+mFckXQsCjctjmEm7x/2P
	oARKcHv1xi3bxh6tK34R1VyBOsdkRDhPekl62OGB/jNogkc/dAWffdtYvA6Ccp/nyf7YImgFw84
	+8fjIheQXiNJoup/Y7VgX23smnz2aWs+DAp/UpAqeYzLkbfaR4i4KW4bDMnlEwOTi8nxRJw==
X-Received: by 2002:a17:90b:3dce:b0:38e:7f1b:f01 with SMTP id 98e67ed59e1d1-38e7f1b144cmr11954633a91.36.1784727635713;
        Wed, 22 Jul 2026 06:40:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea7aa8c97sm1110409a91.9.2026.07.22.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:40:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 06:40:34 -0700
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	=?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Message-ID: <amDIUv4Sa/i7MfEq@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, sdf@fomichev.me,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	=?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
 <20260720-getsockopt_phase4-v2-3-8a08fcfa0d72@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-getsockopt_phase4-v2-3-8a08fcfa0d72@debian.org>

On Mon, Jul 20, 2026 at 09:17:44AM -0700, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
> that takes a sockopt_t.
> 
> No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ieee802154/socket.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index 85dce296d7513..763f63e48afe4 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -831,20 +831,12 @@ static int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
>  	return ret;
>  }
>  
> -static int dgram_getsockopt(struct sock *sk, int level, int optname,
> -			    char __user *optval, int __user *optlen)
> +static int do_dgram_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
>  {
>  	struct dgram_sock *ro = dgram_sk(sk);
> -
>  	int val, len;
>  
> -	if (level != SOL_IEEE802154)
> -		return -EOPNOTSUPP;
> -
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> -
> -	len = min_t(unsigned int, len, sizeof(int));
> +	len = min_t(unsigned int, opt->optlen, sizeof(int));

Does the same min() feedback David gave on the last revision apply here as
well?
