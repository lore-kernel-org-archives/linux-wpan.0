Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23535AC34
	for <linux-wpan@vger.kernel.org>; Fri, 17 Jul 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276584; cv=none; b=ICuy/kDOgjsOwL8MSKJ2YPjzYKeAW9BU/uPkIOy+GUaGj1LZOK0qrSTdW1OfYRDioCplpc+NsBasvgMytKq2k7lngPpTJUvQY0+cQ2WzS0ZALdgE0j5Buupsnr8IvcFp8Sku72vWUz3beMIq7H9oA0DlpdfnvuBXOGqiAGMoS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276584; c=relaxed/simple;
	bh=OgfKQGcUft8+pubZB1n8Cb5kpcRbRtLkKcWVdrtca3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyDYqCIh+mizLekFiQVHIVh25dVcxKNxQomCUO0D6QXVWDjYUnmEgxFEX7HARjA2JUuigKHYgJ/9jRfWpBfHm34J5+UMUVMdm/TuQ4Bmm8N+P1/78Hy9rW7xMvpf59i2DXZaoybMINdft1ssAeh7Kh0PX/x8YeATO946DTRL8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMLWAPlG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMLWAPlG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b27c7451so8637545e9.0
        for <linux-wpan@vger.kernel.org>; Fri, 17 Jul 2026 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784276581; x=1784881381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NLZAfRK2x9zkSee/fqTuHPNp25jE6qaj7rL/KrN+u8g=;
        b=oMLWAPlGU2OR3WEZegsvP74B/Gd742nWs6VsZ04tDu3gwme40AUEOplGxxP514/B4n
         XVLVHEyH6jcE+qV83iuLm1mbEORVJxF0hbr21NsxedYt+EQsTVlnXIQl9CtXj47EyEdY
         u4bGBS7A3kixYCjL4IzEPB0TUIj/FcHdxeG7betOJ1RLOEamIWsmSVG3l0KKkl7ZvVe4
         ieIhEZPnRA3aRIZJd++afq0BUibUthoQzCqufhurnvvpp+DZR9Ex/XOkQ+FpiF5VEmIB
         YP+w8RVIS8FZ3wPHfJB6QLOuZYJOotcOutklD8iglo9hYqZzFuo4K7ThUv90SiaDoWVX
         wQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276581; x=1784881381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLZAfRK2x9zkSee/fqTuHPNp25jE6qaj7rL/KrN+u8g=;
        b=c4ioq3ct1svT+/CHVNLMk7qBcl7mS9Kpp3I1xF92/ldU8o6zSR8VoF3X9dzsFKo7ba
         R9KEpcg59B7nwmnweVLN7P2X7hmcvBG3XL/rp1q43hPjmnNNyiPrLLRszLOsyRW05xgI
         JqeI3Rie/qxIO9vu7B/vAtfQV+gMbCCfTbDXyKNHPX3Bhqt/2X0JVx8BLk53JWlHGWcc
         Sa4Bw5NoUCkZHTXf4+cNyIsim4ioh7/H6w0J6dY0MrhPT/eyKCJVvS7VkEUIip0WktM+
         7C5jfKMqCkTtCMrX26TQ81nS/FXYXZvUtuSipHb0wiGAlvlRJnLgi2oljpATqYvZjEiN
         MAzg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6Em1YOXU/AVA0nA+hC93LaPW6dWxWbe4sEi30Berdwd2Dx3olK3D50bofS3ns1tyXzYybS5raxP8v@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ebLwy2DdpmBXxK2bq8gsTGm2DF30UMflCjZwNYhkC8R0en3T
	azWPf+oP/F0+4DHbIkH0OFrIlp9kMuS8L+aa61jSl6wohFU5aGFYPV/3
X-Gm-Gg: AfdE7ckhjPyhSmiqC5fDKzKAd5vK0LhUbVhbxi89lgF51P2QFmwWBO6TILYA4NCI7v5
	Xf5pRf9p7bj8Ep/NJmw6lZRPiIMTqrqQ7d74K+KdOAzoSf+T7/7rf/xGC2ae4rk/92lDn2VoD26
	KS3SzIp65hA5e3XUPiVylxaSuJXZt89ROFm+b1xCea3M+NfudboV99sJQGS9sK0kcYxzp1f0kMV
	Ok5giihFRfdgTmkqw2I3mm7J9Imiob/dRVDtHR1HHq+bHXP0yWaYD9KxHPJ9hDZnM/1FmmE1/Tk
	uBwVw+PcB+akpSvHxB51IYBlIk0/42fgGXebvOjN35oIeFLyIBbmDBCv+Le7W1hCzqitC+Y5gis
	JdMz/JmF8oPEVCGDfQc/ILjemxqGknafgwkA4uZD17imSGdHMMg5vsptj+T2dwOrZbRLPs+LMn8
	tr1d7l+kol9UGwdicCY88NdFoCw88nUdDJgrYlHPI=
X-Received: by 2002:a05:600c:3113:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-4954a323b14mr16486755e9.7.1784276580733;
        Fri, 17 Jul 2026 01:23:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm59577575e9.14.2026.07.17.01.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:23:00 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:22:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont
 <courmisch@gmail.com>, =?UTF-8?B?UsOpbWk=?= Denis-Courmont
 <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 5/7] phonet: pep: convert getsockopt to
 sockopt_t
Message-ID: <20260717092258.776e63db@pumpkin>
In-Reply-To: <20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
References: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org>
	<20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 06:00:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> Continue converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, splitting pep_getsockopt() into a
> do_pep_getsockopt() helper that takes a sockopt_t.
> 
> The thin pep_getsockopt() wrapper keeps its __user signature for now:
> it builds a user-backed sockopt_t with sockopt_init_user(), calls the
> helper, and writes the returned length back to optlen. The helper uses
> copy_to_iter() instead of copy_to_user(). No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/phonet/pep.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/net/phonet/pep.c b/net/phonet/pep.c
> index 60d1a5375725b..c7f4ce894af56 100644
> --- a/net/phonet/pep.c
> +++ b/net/phonet/pep.c
> @@ -1078,17 +1078,11 @@ static int pep_setsockopt(struct sock *sk, int level, int optname,
>  	return err;
>  }
>  
> -static int pep_getsockopt(struct sock *sk, int level, int optname,
> -				char __user *optval, int __user *optlen)
> +static int do_pep_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
>  {
>  	struct pep_sock *pn = pep_sk(sk);
>  	int len, val;
>  
> -	if (level != SOL_PNPIPE)
> -		return -ENOPROTOOPT;
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> -
>  	switch (optname) {
>  	case PNPIPE_ENCAP:
>  		val = pn->ifindex ? PNPIPE_ENCAP_IP : PNPIPE_ENCAP_NONE;
> @@ -1112,11 +1106,33 @@ static int pep_getsockopt(struct sock *sk, int level, int optname,
>  		return -ENOPROTOOPT;
>  	}
>  
> -	len = min_t(unsigned int, sizeof(int), len);
> -	if (put_user(len, optlen))
> +	len = min_t(unsigned int, sizeof(int), opt->optlen);

I'm pretty sure that can be min().
More generally I'm not at all sure about negative lengths.
Historically the user type would have been 'int', but it got replaced
by socklen_t which is probably unsigned.
(IIRC one of the 64bit Unix had started using a 64bit type but I think
it was sun objected to making that change so socklen_t was born.)

Also truncating below 4 bytes makes no sense here on BE systems.
Some code will try to write the significant bytes out, but that
would be better done in the wrapper.

> +	opt->optlen = len;
> +	if (copy_to_iter(&val, len, &opt->iter_out) != len)
>  		return -EFAULT;
> -	if (copy_to_user(optval, &val, len))
> +	return 0;
> +}
> +
> +static int pep_getsockopt(struct sock *sk, int level, int optname,
> +			  char __user *optval, int __user *optlen)
> +{
> +	sockopt_t opt;
> +	int err;
> +
> +	if (level != SOL_PNPIPE)
> +		return -ENOPROTOOPT;
> +
> +	err = sockopt_init_user(&opt, optval, optlen);

Have I not looked at these before?
Why is this here, not in the outer code?

	David

> +	if (err)
> +		return err;
> +
> +	err = do_pep_getsockopt(sk, optname, &opt);
> +	if (err)
> +		return err;
> +
> +	if (put_user(opt.optlen, optlen))
>  		return -EFAULT;
> +
>  	return 0;
>  }
>  
> 

