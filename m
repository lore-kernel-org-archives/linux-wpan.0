Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC22D59E8
	for <linux-wpan@vger.kernel.org>; Wed,  2 Sep 2026 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335797; cv=none; b=X/mPRDKW8BoX5evGClgW5TiDqovUOzMeVT/KuGv8NNf1uXwVJxmB/P4AXeO3GZif2sOyRuMVr5Kt0aMDjwtMHMNsDY9dluTOW/XRz/LIL9XiUyj4uMejqGsxyFC/xHHNKGkaC4+TDRHplI5skuN9uKQWoNj4nY38DBf+EkmrxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335797; c=relaxed/simple;
	bh=/XymiVWzr7xJsDEAUobH0GlYqXxowFCSbrwNSjaI6Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKthA7aNFLMMKGMGx3A4sFpZHXvMs6et/PsISoxsvS1vqodbDF6eucRNnZ992VRMilCopzZ/RgQU//qGAiVj5cOJ5EYIkCvQ+YpJddgiMODMwFINbfsBqtQJqJkocTuyFEd6RJOoLp0IHmDVcIQziRxY3hf0JtPWXD3pC9dIB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 00B82C0182;
	Wed,  2 Sep 2026 09:56:32 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: linux-wpan@vger.kernel.org,
	Zhiling Zou <zhilinz@nebusec.ai>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	marcel@holtmann.org,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
Date: Wed,  2 Sep 2026 09:56:24 +0200
Message-ID: <178833577858.3379389.4139356708516273855.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <0b715da69bd15a86ddc47dad5cf12da648211050.1787997209.git.zhilinz@nebusec.ai>
References: <cover.1787997209.git.zhilinz@nebusec.ai> <0b715da69bd15a86ddc47dad5cf12da648211050.1787997209.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Zhiling Zou.

On Sat, 29 Aug 2026 18:07:23 +0800, Zhiling Zou wrote:
> TUNSETLINK allows a TUN device to change its link-layer type to
> ARPHRD_IEEE802154 without initializing ieee802154_ptr. lowpan_newlink()
> checks only the device type before dereferencing the pointer, so an
> RTM_NEWLINK request can trigger a NULL pointer dereference.
> 
> Reject devices without ieee802154_ptr along with devices of the wrong type.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
      https://git.kernel.org/wpan/wpan/c/bf79662bc85e

regards,
Stefan Schmidt
