Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47263 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752526AbbFIOFz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 10:05:55 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 6832F140D69
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jun 2015 10:05:52 -0400 (EDT)
From: christoffer@christofferholmstedt.se
Subject: [PATCH v2 wpan-tools 0/2] Update CCA mode and CCA options output
Date: Tue,  9 Jun 2015 16:05:36 +0200
Message-Id: <1433858738-25445-1-git-send-email-christoffer@christofferholmstedt.se>
In-Reply-To: <20150604092001.GA8027@probook-6560b>
References: <20150604092001.GA8027@probook-6560b>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This patch series updates the CCA output text when running "iwpan list".
Instead of the single digits indicating mode the output is now strings
describing the mode and options.

Changes v1 -> v2:
* cca_mode number is removed from "current cca_mode", only text is printed as
an example:

	cca_mode: Energy above threshold
	was
	cca_mode: 1, Energy above threshold

* Changed "enum" to string mapping in print_cca_mode_handler. Instead of
printing out the strings in the function I return a tempbuf that is formatted
by the caller.

* Added default value to cca_opt when printing current cca_mode and cca_opt. It
is set to the "random" value of 99 as the enum only has 2 values, is this a
proper solution? (or should we use limits.h with MAX_INT perhaps?)

PS. Also configured git send-email so trying it out now to the wpan-list and
hope it works this time wiht proper In-Reply-To header.

