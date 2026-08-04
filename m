Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C323F4DD0;
	Tue,  4 Aug 2026 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840017; cv=none; b=cHkGA8rabgjJNLL8fxsoJceNIUnowXwJVVl6Jz0uh0E8hL3oK4IqcbYP/ajs0Na8TVD1VzsdjsEqjiqYOyMRYUxrzXlAh7WeHJW3/6G5Mk7zz0Z2gJPtUmqVkkR7o5KLpfS0PjmhQVcsKZ56r3iN/gUtt/fq67CE7EbilxF3fiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840017; c=relaxed/simple;
	bh=fStvCxBQ7zDCSzGFLgYwNmwThG2Zq7ZdyZ/ko/vJWhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzqcAQRvQ5sZ0gsDXGEpJv8kKA2Zg9ET6LI4bqUUlUf//l8wMMGI5KUWbmj6I/pDTT54OgWiDVbrV+Ud+YN4AIcTO8JrFBNpuYLiilJVDfj70HkkNF9ELhwrM+y2rSvNsXI/mFAd6Vua+0Ts6DyghejkT6fz3QcOEdOQ7dENQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LHDz7WAP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LHDz7WAP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 84EAE1A13FC;
	Tue,  4 Aug 2026 10:40:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 458546029E;
	Tue,  4 Aug 2026 10:40:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E54511C32A48;
	Tue,  4 Aug 2026 12:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785840007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=X+UeAoxXc6gjQ43pY25b6outJdizFVbCTBU7jjQNIY4=;
	b=LHDz7WAPLUrG67hF3WjOyGrkWto8Ej36xQzJ2tFCRMfYLqRZNv3t+7rUkXb8dTLiN6yHoL
	SPj7mmIEmhOBQc0/Uvhf5qLBtSlq+4TUiZogZ3sqrSlfMb4lpXlBr7PzuvPQfjH5Tv3hWY
	wJsk+ssiUA/8+qfTo0lAEzaeGFwB2l4nHo2yrsTSr0rxv71n3UZ7/iQfgSF3dPmmJ0SvjD
	uL1xZiP4gRiFqYNpJ8WkfEYW6jBPGpyTwDjj81kCUxzQFuuzyTu8Fs7C63B6hwOp+6n/NL
	+V5Q2SWCGXQhsCLFJmcobRPGJ3M8smu4Z+vs4Ize1qavXEu+t261WP9rxgvekQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  pabeni@redhat.com,  horms@kernel.org,
  david.girault@qorvo.com,  vega@nebusec.ai
Subject: Re: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon
 worker
In-Reply-To: <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
	(Zihan Xi's message of "Sun, 2 Aug 2026 09:23:34 +0000")
References: <cover.1785596603.git.zihanx@nebusec.ai>
	<e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 04 Aug 2026 12:40:03 +0200
Message-ID: <87ecgegoe4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 02/08/2026 at 09:23:34 GMT, Zihan Xi <zihanx@nebusec.ai> wrote:

> mac802154_beacon_worker() reads local->beacon_req under RCU and derives
> the sub-interface from the request, but then drops the RCU read lock and
> continues to use both sdata and the embedded wpan_dev.
>
> mac802154_stop_beacons_locked() cancels only pending beacon work, clears
> local->beacon_req and frees the request.  A beacon worker that is already
> running can therefore continue after interface teardown and dereference
> the freed netdev private area.
>
> The scan worker already pins the netdev before leaving RCU.  Apply the
> same lifetime rule to the beacon worker: take a netdev reference while
> the request is still protected by RCU, and release it on all paths that
> continue after the reference is acquired.
>
> Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Looks okay.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
