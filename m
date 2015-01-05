Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60755 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbbAEVdO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Jan 2015 16:33:14 -0500
Date: Mon, 05 Jan 2015 16:33:11 -0500 (EST)
Message-Id: <20150105.163311.1868277821228057884.davem@davemloft.net>
Subject: Re: [PATCH] at86rf230: Constify struct regmap_config
From: David Miller <davem@davemloft.net>
In-Reply-To: <1420448551-9443-1-git-send-email-k.kozlowski@samsung.com>
References: <1420448551-9443-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: k.kozlowski@samsung.com
Cc: alex.aring@gmail.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Mon, 05 Jan 2015 10:02:31 +0100

> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied.
