Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CD3B71CC;
	Thu, 23 Jul 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800312; cv=none; b=dh6ookw1yMEv1BKsgIdUQHw0gQFevAWxn/HgscJPdR+62oqF1j/is0gDWWnA2ccUd3c8vnlo3MWaBSTXfWKBYEYGzGZjYPzTtr56XMlEurezWLKLdVTy7EuWYwOTYY5qTh0tH/QOn2Bsh1HOvlJ9d57Cv8bCD58AMXlA+6jtWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800312; c=relaxed/simple;
	bh=P5Wh4TrkCW6ED8kocuAlEWyWAe4gq8kh82kYAh84Qiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJla1IXsugVm54e9DKtytVQyZo5w6gRHzHnUGnPbjFognOzWfACQTwIVw+sc7fPjyMCDJxub9zkSS2QXj2PwOrGRUOOJ/xJgK/KTaWzEl27A5wbiazbLxY1BNeSqjTfshl+hYt7WlrDuTAIVxgkBvodwgMAkMrM6i+MKgzpVdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dg7X4k8j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JR73Cea4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dg7X4k8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JR73Cea4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E14A14000E8;
	Thu, 23 Jul 2026 05:51:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 23 Jul 2026 05:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784800307; x=
	1784886707; bh=cL0CCyc/zlAc782RIGVb7q+r3hdXioHxIggZto+D5VI=; b=d
	g7X4k8j3QU2Zq3Bs8i3PVaZabDbX/6M1/B5oWaeXC3AP/4CGDC7ekeL1/AeZlGes
	3BGpQLV+9zjZ7LZVSKawbRcrkSfbj48cgLVm7vTrvc4ZVfspt02EwBRUSiSIdaP3
	Bz2vjAoIa1Vz6le2zjNunptya43bO0yjnAHiRRKgUXLfqroyO0LO90LE9jM/TI2p
	Ifx9/39ZZ2IyYQYjJBhPGa1Ce3yCXud7o7ZHowbL62cpSa+Lmfy9se7M135jWuYL
	A8h/i9uxRj+D+knpZ0d5jLdXHBSsQNuhmonEF80m7KFNc6bqbwiIlGSmo4QAEfvP
	0ndD9Z9iH/gSHELVKG8Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784800307; x=1784886707; bh=cL0CCyc/zlAc782RIGVb7q+r3hdXioHxIgg
	Zto+D5VI=; b=JR73Cea4fEVVJevKKdCZ45PiHndpPMAYjoRgTOgEi+XGU7SN8ki
	ws+IRmGMEMy63TXDsQGAkGyznBqJlIHdtejrZnz8msmZO95k9RfgE/Bm+zMuGcZN
	IncL/YUfmWoMKcN/WTlCEOZam+CdEeuXahYsvAlxFUXGlrKBLdYBvzFGsjXrZdGy
	SHJ0PhuLUNfEaWns/wGuRsFu5IJddZ+T0weqoWH47MfxaBQBD1AWxE/GzW0B9Q2u
	fctfw+9gVAANsIDryN9IreUoPj2JhUwcKWBH8Nb3n68b8lDFrZwzvHGjdM6BsS+X
	A3wHqqI2WJCVrmCL/SVMgHwHesfNaicP8Bg==
X-ME-Sender: <xms:MuRhaoIiJHY0oLk08sc5qk997vdVcUBrqBlVukuDNpX3s48YNCBs5w>
    <xme:MuRhavHaHmVmPEHviB-iE3rGLnCY8r3SGT2WUO0IhE0JMU6e_lqpYc20MD8UBSkfe
    XBuGS7PIHwsG48BwMwHsvuq6O_2eFOWhkt3ahS2aYGqrqYCJEllzAA>
X-ME-Received: <xmr:MuRhatwQ80zKpLHwPcXnHxGTlY62l0xhzFj8f3Nt43coMIS0V8Jf9cD7Ue8>
X-ME-Proxy-Cause: dmFkZTFJy/Gm5y8scJPGCyO8SFCHrQCoW9oaAVAjG+x6/ktgCZg78o1KvxXp+KzmGOWmo+
    eFlJnuALyWH3eJn2iK7RmWrd3yxs1/YXOCiG2LnUZnW2rATb1pi78l89nHehXzIL+wiqaR
    ccIjdfWaUFcRaxwBPTiw+6dcFSIMmNbVOkCTOuttLY6a8gkXeWmD3Fo3rXTfx031A5LncR
    uplBasemc4Ig2Ab4JLX1FQvUv0x9FGdLqEb8YgNJR7VCmyNHWsvUU1Zmox4JJYqRAlXycg
    A1DwNGu7lg702cGxwtgQmxD75TeRVcFl8N7REOK0r+NbIkMh4gkUOPvhLo/eSyvZnnQji5
    AgWiJ4BB0odhMhGT/B41ee+lHVY6gHoE1rY4smH3z7k/p61E30pBrIltsQf2y+io6ngIqq
    7trJmM0ep+HcZ6GyeD29aKDiC4XwK3i0w3SHr57i/dYQ2zp7b7T2Ab9pafDcctm36lH0KI
    RVBSMfkUoQiD/zo2Kv3ggwmXCuAcZPB/mYcqwFDynuuYW9qvFCjdyKJdynfsaoY5sZuPub
    IFhMNaJbVC3Kg9yh2zU1zBXeGtZCwa7Mt0I/WklFZ8S8TQObXJ5Yb+btP1BkHFTx4/kFIK
    4pL5eiqxnZMVnUJpGqc5ZPR4jnNDo13Jsp1jovqZyI589ox0tAWyhrA/XYFA
X-ME-Proxy: <xmx:MuRhasgNKpwcCyYFI5ynHtz9P9uLZhoE5J5PEMBfrUzSJGdG8FQhOA>
    <xmx:MuRhaqKCCIW9FpOe6kxUYCCQkVo8KldtIlskOK9sb4YTdRdqf2uDkw>
    <xmx:MuRhanACJ7BuKwIc3Su74jp41_w4onYL3X5rOJNKBpSUMTD8ovhXfQ>
    <xmx:MuRhajTyWJ9oCni52q6aXLuUHO1xZaZJLLSb7rzpj-BcGHWbcqcpeQ>
    <xmx:M-RhamonwTVcE4_ZFN18rO2e5H-kSrlPsc6NsRvu8uvesW6Tf35-KEmO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 05:51:45 -0400 (EDT)
Date: Thu, 23 Jul 2026 11:51:43 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 6/7] tls: convert getsockopt to sockopt_t
Message-ID: <amHkLwihrCUx-_pk@krikkit>
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
 <20260720-getsockopt_phase4-v2-6-8a08fcfa0d72@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720-getsockopt_phase4-v2-6-8a08fcfa0d72@debian.org>

2026-07-20, 09:17:47 -0700, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> interface, converting do_tls_getsockopt() and its per-option helpers to
> take a sockopt_t.
> 
> The thin tls_getsockopt() wrapper keeps its __user signature for now: it
> builds a user-backed sockopt_t with sockopt_init_user(), calls the helper,
> and writes the returned length back to optlen. The helpers use
> copy_to_iter() instead of copy_to_user(); the NULL optval check in the
> TLS_TX/TLS_RX path is preserved by testing the iterator user buffer.
> 
> No functional change.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Looks ok, just a few small comments:

> -static int do_tls_getsockopt_conf(struct sock *sk, char __user *optval,
> -				  int __user *optlen, int tx)
> +static int do_tls_getsockopt_conf(struct sock *sk, sockopt_t *opt, int tx)
>  {
>  	int rc = 0;
>  	const struct tls_cipher_desc *cipher_desc;
>  	struct tls_context *ctx = tls_get_ctx(sk);
>  	struct tls_crypto_info *crypto_info;
>  	struct cipher_context *cctx;
> -	int len;
> +	int len = opt->optlen;
>  
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> -
> -	if (!optval || (len < sizeof(*crypto_info))) {
> +	if (!opt->iter_out.ubuf || len < sizeof(*crypto_info)) {

Not something about your patch but... I really wonder what this NULL
check was trying to accomplish. The other getsockopts in tls don't
have one, I don't think the rest of networkng does that either.


> @@ -591,12 +574,25 @@ static int tls_getsockopt(struct sock *sk, int level, int optname,
>  			  char __user *optval, int __user *optlen)
>  {
>  	struct tls_context *ctx = tls_get_ctx(sk);
> +	sockopt_t opt;
> +	int err;
>  
>  	if (level != SOL_TLS)
>  		return ctx->sk_proto->getsockopt(sk, level,
>  						 optname, optval, optlen);
>  
> -	return do_tls_getsockopt(sk, optname, optval, optlen);
> +	err = sockopt_init_user(&opt, optval, optlen);
> +	if (err)
> +		return err;
> +
> +	err = do_tls_getsockopt(sk, optname, &opt);
> +	if (err)
> +		return err;
> +
> +	if (put_user(opt.optlen, optlen))
> +		return -EFAULT;

One of the sashikos complains that we're now writing the length with
put_user in cases where we didn't before. I don't think we need to
care, but if someone complains, we could make this conditional on
optlen having been changed by the handler.

It also complains that optlen was getting updated on EFAULT and now
it's not. There's possibly some code out there that's crazy enough to
pass a bogus buffer to get the size it should have provided?

Also some complaints about "what if optlen is negative". I think we
can ignore all of that.

-- 
Sabrina
