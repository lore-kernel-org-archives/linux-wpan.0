Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07888360EC6
	for <linux-wpan@vger.kernel.org>; Wed, 22 Jul 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727765; cv=none; b=Ah4rM9y1ba825PaICfXhLuKME911e1ITanIGzVXEa8IQU+6me6lSeIqIU4KaWeLqpD7xZlYUZaq4Ae0tSFPQEA77QjYDtQqTkucwARQ0tBfOb7G+u1LveR1oL154qgl1Ip8ZnP12wcVUw56TN9RFmJVxq0Wv4JXXFy3MIDzxGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727765; c=relaxed/simple;
	bh=4Ed3FEjfLXijc1yxxqYpI07on3pOxk69h5KyHejFQJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRaKEvXmAV+2n4XeJy/3ZkWhuSp/yC9qQaPR4Sy0Av2v4szbHlIWR8r6HqLaMIaUpOmMgWaC4PDDHmLiu//N1I+lKALIqPKy7pLxsu+sVLZWTTJLY9Yg7gqvmn4oZ/aKqTXmuujTF7zwdyTXBaldoC3i/qokxKKSc6ZBYWZkJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=fAuQ0Sjg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="fAuQ0Sjg"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so7893926a12.1
        for <linux-wpan@vger.kernel.org>; Wed, 22 Jul 2026 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784727762; x=1785332562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crZ98YrnqpB8dh6d/2NV8XT+VsDzcgb/h4PFQm4GzmE=;
        b=fAuQ0SjgGEzflEvVmT31aZ57Z0IZ4xVjKso+L+ulcIWts2Al/6Hu5A28ThiCeYYx3M
         mDOsGRilucUNjW6OGWImDwKYS6lG/Rj5tOKHra04WdoiHH9l4Pzuei/msEWzbuv48ID1
         RJNEj9cw12isIyZ2jmXOeKl0OPSWAlExI8D5G5jCRnAm8+vGnVyW0M9XnjMRzPBHVK0L
         WdF33SIdor1wgNkS2E1ev+LEKe10nMnbQeoiU6qtsQIznPGwXLKqudU3cR89hWHttz6A
         g4k5ogWr/EbkkQ4sjHFdoZFJIi2lWH+4uvbpFWe0fHQ3aS9QpERRyAh3b28IpXA3ec+m
         SMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727762; x=1785332562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=crZ98YrnqpB8dh6d/2NV8XT+VsDzcgb/h4PFQm4GzmE=;
        b=afVdiMAnPigwoSCgINeRoZ84G0HxZoihbLFJopangHwKpaD7SNMHfv9a51Xa/1qWQm
         LhLJl6qZOvLfk3m4umIvgZYP+EBwgUIbqwKgxuHL5T96EsV2MAp2ejF4EcxXs5MPUc1Q
         93bW7hZl8X3Bwkrj25eqFNHs40loToGN0BZ0ldILE/J4jq3GY2kizjPmpiLEazMEmVhw
         JUX3fijw/gwV7V9UU6Kg7zM0Ge6qFboYG1X1PZv1E6br5aIckt2Cckzg8FfzXkJjkRBj
         hik2dVmp9slWAsIOxVgsujoEWi2M8UH4rtHn5FJ/lNVd8fIDy3I3jKL1eu65lXzX7Eq2
         5UMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrG8xZGES9zUh7qk9Y1ZquUUUyO0DN+fy4/ce08QcDWQhgKwh6D3Nua0jkx0AhGJiwkf59TmWIAyVIj@vger.kernel.org
X-Gm-Message-State: AOJu0YxgshrTMkJ41I9CdbD9tvdUXfeP6ZbVMuy54lp9+BAbxYF8wAqR
	nUmcEsYb8qRYM7N3k7PLqiSpGjPwp5slek0OayLaBQToWgH1QqbDfPOjtar2X4b7J2s=
X-Gm-Gg: AR+sD10xQgWmqdNL4v1epYiRsQaa9s0GyGmw7JkgE0BorCOl1MgiSj71sF6WqtDuBO1
	HOtLev1ZprHIctIXvW1pmnqDVee38zQe4hcfPqoV2rsm3fygV96YX2yxwxSRogNjlTg882Jnwrc
	rwtEj6h7wNHoEpHl7v7jm2AzErqNEL3rtiayPfl0TmGA4CHfmPQAloTkAgHqafr9X7kqHE6RaOh
	drDch4lg+0HcV2Zc1wb/GVIJ4CeZs2ow5cjssbRRrWDNIZFNZmHwZuQ50X2y+viLXhIdortDmVQ
	+FLho5i0Je5jg7gPa7yA1O/GFEnqtIn6zk3PNa34vEXTlzC0grWTMrH0gz4oP++3cIifvUIQrPG
	1j9lMK98jPymYpIS+ZbeUcm6yJSohmH2kDGp8DOYpcLXSOSnShqsnLOv5guWQP5tpw7EwxA==
X-Received: by 2002:a05:6a21:510:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3c419169f4fmr7786967637.12.1784727762450;
        Wed, 22 Jul 2026 06:42:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0d872bsm1233076a12.7.2026.07.22.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:42:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 06:42:41 -0700
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
	kernel-team@meta.com,
	=?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH net-next v2 0/7] net: convert rawv6, ieee802154, phonet
 and tls getsockopt to sockopt_t
Message-ID: <amDI0T9mfHakF+7I@devvm20253.cco0.facebook.com>
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
	kernel-team@meta.com,
	=?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>

On Mon, Jul 20, 2026 at 09:17:41AM -0700, Breno Leitao wrote:
> Now that sockopt_init_user() was already merged, builds a user-backed
> sockopt_t from the __user pair. A getsockopt leaf can then take
> a sockopt_t behind a thin __user wrapper: the wrapper builds it, calls
> the leaf, and writes the length back to optlen. The leaf copies with
> copy_to_iter() instead of copy_to_user().
> 
> Convert four more leaves the way udp and raw already were: ipv6 raw
> (do_rawv6_getsockopt), ieee802154 dgram, phonet pep, and tls
> (do_tls_getsockopt and its per-option helpers). 
> 
> Converting phonet surfaced a pre-existing bug: pep_getsockopt() clamps the
> length it reports but writes a full int with put_user(), overrunning an
> optval buffer shorter than sizeof(int). It is fixed in its own patch, with
> a Fixes: tag, before the phonet conversion, so it can be backported alone.
> 
> The last patch adds getsockopt_iter selftest fixtures for rawv6,
> ieee802154, phonet and tls, checking the returned length and errno across
> exact, oversized and short buffers, an unknown optname and a bad level.
> 
> For full motivation about these changes, please check the initial thread
> at link
> https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/#t
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Replace min_t() by umin() (David)
> - Link to v1: https://patch.msgid.link/20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org

Other than the nit I mentioned about min vs min_t on the one patch, it looks
good overall to me, so for the series:

Reviewed-by: Joe Damato <joe@dama.to>
