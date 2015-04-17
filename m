Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37701 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbDQK14 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Apr 2015 06:27:56 -0400
Received: by widdi4 with SMTP id di4so15436875wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 17 Apr 2015 03:27:55 -0700 (PDT)
Date: Fri, 17 Apr 2015 12:27:53 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] ieee802154: Add trace events for rdev->ops
Message-ID: <20150417102749.GB3288@omega>
References: <20150412120733.GA6181@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150412120733.GA6181@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

On Sun, Apr 12, 2015 at 02:07:33PM +0200, Guido Günther wrote:
...
> +DECLARE_EVENT_CLASS(802154_le16_template,
> +	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
> +		 __le16 le16arg),
> +	TP_ARGS(wpan_phy, wpan_dev, le16arg),
> +	TP_STRUCT__entry(
> +		WPAN_PHY_ENTRY
> +		WPAN_DEV_ENTRY
> +		__field(__le16, le16arg)
> +	),
> +	TP_fast_assign(
> +		WPAN_PHY_ASSIGN;
> +		WPAN_DEV_ASSIGN;
> +		__entry->le16arg = __le16_to_cpu(le16arg);

When "__entry->le16arg" is type of "__le16" which is given by
"__field(__le16, le16arg)". Then translation of __le16_to_cpu is here
wrong because __le16_to_cpu return u16.

> +	),
> +	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT ", pan id: 0x%04x",
> +		  WPAN_PHY_PR_ARG, WPAN_DEV_PR_ARG, __entry->le16arg)

When then we need to do the translation here. The format string requires
a host byte-order type. So it's __le16_to_cpu(__entry->le16arg), I don't
know why sparse (the C=2) doesn't report about that.

This is like wireless it does at [0], but with a pointer. When wireless
do that in kernelspace, then I have no idea why there is a cfg80211
plugin which doing byte order translation at [1]. I think this not for
parsing the argument, it's for correct handling of handling the display
of __le16_to_cpup (We use __le16_to_cpu here).

Then we need a cfg802154 plugin in trace_cmd for handling "__le16_to_cpu"
correct.

- Alex

[0] http://lxr.free-electrons.com/source/net/wireless/trace.h?v=3.19#L2160
[1] http://git.kernel.org/cgit/linux/kernel/git/rostedt/trace-cmd.git/tree/plugin_cfg80211.c
