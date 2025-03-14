Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBC13A244;
	Fri, 14 Mar 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934290; cv=none; b=NOmjVwc5Ikt2U/h1snlwVj2nHlRef8O18xkZ+Esq0GZed2jOcLbFeMhCmZm7u+fNgxUW4bIuQ8kdxCKmXBO+pAShXYMi5voaOb6qaZsxzLjUrwbfUP/PgbBwF9u3NnCc1kD8oueATdzS5snZvKbUF7OLxTSmui4+IeV3p10kThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934290; c=relaxed/simple;
	bh=z8lG/iytWZ1MDf7eUS10O5PYpdUp7OzCeJtWL/rC4jI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bA/MkeAGNlpPNz3XeBvTeShBnptw7aN9PnBSZfaqrhb8FbWv9caefErjkyhPfKMzO6hoIyI9aUOBZ1QtQh/whH6tPiBj2UgYvLHS28laZ7Gn82RhC7F12FU87ustHK5ZZ8mzgb8BtJX2VSRpo74DvacX9H4s7czIgIJL6zJnf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=WTE06X8N; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="WTE06X8N"
Received: from [192.168.2.30] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id E7883C0183;
	Fri, 14 Mar 2025 07:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1741934278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bm3q1T2t2AGrSMqbsyzCgboJjrfuzn+AT6oxv2TYz88=;
	b=WTE06X8N/+E/zd9WOYB993TRpOwiNEGXfp9nD9H1hnSlRAaqkhgPe/R1PNJsC/ctomMWgR
	Z1aOThRW4LpaUuYQeywWRf6ckjimtwmEV0QcfChL+VN3OZIDcojHX/PiIYmOa7jLjj3VaE
	b4ho9axmhq80BpS1lYyRi2flxysOoLZ7NEAQMs11lJf3Y/UijjVzHBjycOkWLebHZAb61J
	HxBw05xsdyfmrEeByUDRDeWniBl+w93wn5ig42kcvwfKOH2MhXkmPWlvbUGLFJ7u6GbGb0
	sNySgApQo41eYp10E1pJRDwTO2Kdp8Mmbu3hKRZwqcTj5gJOnmpSpT5pjF9Lhw==
Message-ID: <91648005-0bf9-4839-8b8f-5151056c9f9a@datenfreihafen.org>
Date: Fri, 14 Mar 2025 07:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154-next 2025-03-10
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20250310185752.2683890-1-stefan@datenfreihafen.org>
Content-Language: en-US
In-Reply-To: <20250310185752.2683890-1-stefan@datenfreihafen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 10.03.25 19:57, Stefan Schmidt wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net-next* tree:
> 
> Andy Shevchenko reworked the ca8210 driver to use the gpiod API and fixed
> a few problems of the driver along the way.
> 
> regards
> Stefan Schmidt
> 
> The following changes since commit f130a0cc1b4ff1ef28a307428d40436032e2b66e:
> 
>    inet: fix lwtunnel_valid_encap_type() lock imbalance (2025-03-05 19:16:56 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2025-03-10
> 
> for you to fetch changes up to a5d4d993fac4925410991eac3b427ea6b86e4872:
> 
>    dt-bindings: ieee802154: ca8210: Update polarity of the reset pin (2025-03-06 21:55:18 +0100)
> 
> ----------------------------------------------------------------
> Andy Shevchenko (4):
>        ieee802154: ca8210: Use proper setters and getters for bitwise types
>        ieee802154: ca8210: Get platform data via dev_get_platdata()
>        ieee802154: ca8210: Switch to using gpiod API
>        dt-bindings: ieee802154: ca8210: Update polarity of the reset pin
> 
>   .../devicetree/bindings/net/ieee802154/ca8210.txt  |  2 +-
>   drivers/gpio/gpiolib-of.c                          |  9 +++
>   drivers/net/ieee802154/ca8210.c                    | 78 +++++++++-------------
>   3 files changed, 41 insertions(+), 48 deletions(-)
> 

Friendly reminder on this pull request. If anything blocks you from 
pulling this, please let me know.

regards
Stefan Schmidt
