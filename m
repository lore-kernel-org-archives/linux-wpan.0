Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778103;
	b=XN8/SJvq2tLQdgPoi2o/HyZ4yZSRpwqpOm/ydLXscWbJfYVIwVq9LI1BxZvIfV3VIlxo
	 vNOTS2dO3kw+LAlMMv3xr5w+PAvImy1+ROHbEgkco+xE3ou5Tst7hnCUbCboxYwfqgsMI
	 iTWPpJO8GnLGaKSXPjBn5Waiv3n/xuVYxJkW5khYBAz7RDXtKaC/3o4LaX3e+RrR5e/2B
	 p+uXkZlnQHZbQxh84gkRue19YH+DcxkXMs/jhySudmpJywVj1ouymYftfHqVHL7PLtGnM
	 oIh/mo8XB1wGCv+HN+a9rObU4/TBQjpTrj5uc4MgasiZgY0vFnOVr+aB5TzbYIdmXqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778103;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=orxc0cOYIwRhmILtAs0pWXdJW9rWB8yPgs6rqTd8ufY=;
	b=zpOwDBtpelF5ZJX2LjRpfkGruZyCt9gVqFbYz9OpX6UXkdm5RA/YYctn+blXtyRx8Gbc
	 yCQQmuYo+9zCYGKAlxQ1VhiHyPrTwmmjuQTqH8ZP8/DUcOJgcgY44F5WIdQVQHnUcIGo7
	 /rhwiq/4uNZipJXz2oJKWM0ZaFjeOJ7cqw0I9ijXn5kdjUlIWZzsBn6dPHPhJSh5XQKnx
	 WOQPFwsHny0Wdn2gv8CCj3m0EqonYsx1ERpS0n/wRVXJxzAs0IwwWY7I1fzOEMjaNjjEe
	 xy8rbpPLzhL0Vm7V+6r7ru2dp4sZZdCR7Jngz7gCiX8t166Hxgmi6nl7tRGp2n5KvFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cSa/t5JA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25B606A339;
	Wed,  4 Nov 2026 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSa/t5JA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB95F1F000C1;
	Wed,  4 Nov 2026 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778102;
	bh=orxc0cOYIwRhmILtAs0pWXdJW9rWB8yPgs6rqTd8ufY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSa/t5JAw24C9Yao6g8ttsz5OCtrEowHRhAxKL8CMJ9cWq5nJLL6/YvKyniAE6YX/
	 +lcyZi5Y/DXzQhzWavv8DfYt+AbJwX3DRTD6wlFllgQ/NoYz2NA0Tz1jWvObIbgMDN
	 XQ3SIgOKqnOYV4dQ9s20utGB0pj2EjPfqxU9y8dM2UaggNb4F0G2iMIT1q16qZXgzj
	 CG3ey8eNJyOQ1ewghudKm/PX+L3Xxxko0iWSnOPuTsdJhuXzkXFbNuY7KMCrKCGvAM
	 Le/0SwEMrEKybQzEXLTChGiZPSRf+B/rDZmbINt4Us6d0j2ks3EGKcxazTUsQOKm+5
	 TjFj9g7jmIjHA==
Date: Wed, 4 Nov 2026 08:41:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Simon Horman <horms@kernel.org>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] ieee802154: drop the extra phy reference in del_iface
Message-ID: <20261104-diamond-kittiwake-of-progress-bc547d@quoll>
References: <20261104022809.1484165-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104022809.1484165-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:09 +0000, Wentao Liang wrote:
> ieee802154_del_iface() takes a reference on the phy of the interface and
> then looks up the phy named by IEEE802154_ATTR_PHY_NAME, which takes
> another reference. When the optional attribute names the phy of the
> interface being deleted, phy and phy2 are the same device, the lookup
> reference is not dropped and the function later puts the phy only once.
> Deleting an interface while passing its own phy name therefore leaks a
> wpan_phy reference.
> 
> Put the lookup reference in the matching case as well, leaving only the
> reference taken from the interface.
> 
> Fixes: bb1cafb8fc41 ("ieee802154: add support for creation/removal of logic interfaces")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/ieee802154/nl-phy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




