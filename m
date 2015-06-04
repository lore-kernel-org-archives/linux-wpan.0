Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46348 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753190AbbFDJUO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 05:20:14 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 378A8140D8C
	for <linux-wpan@vger.kernel.org>; Thu,  4 Jun 2015 05:20:11 -0400 (EDT)
Date: Thu, 4 Jun 2015 11:20:06 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH wpan-tools 0/2] Update cca mode and options output
Message-ID: <20150604092001.GA8027@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Earlier cca_modes and cca_opts were printed separately but these two patches
now prints them together so cca_opts are only printed when the specified mode
 is (3).

Output for "current" mode (only one line is printed for each wpan):
	cca_mode: 1, energy above threshold.
	cca_mode: 2, carrier sense only.
	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'and').
	cca_mode: 3, carrier sense with energy above threshold (logical operator is 'or').
	cca_mode: 3, carrier sense with energy above threshold (logical operator is unknown).
	cca_mode: 4, ALOHA.
	cca_mode: 5, UWB preamble sense based on the SHR of a frame.
	cca_mode: 6, UWB preamble sense based on the packet with the multiplexed preamble.

capabilities:
	...
	cca_modes:
		(1) energy above threshold
		(2) carrier sense only
		(3, cca_opt: 0) carrier sense with energy above threshold (logical operator is 'and')
		(3, cca_opt: 1) carrier sense with energy above threshold (logical operator is 'or')


Christoffer Holmstedt (2):
  info: add cca mode descriptive text to output
  info: remove old cca options capabilities output

 src/info.c | 99 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 39 deletions(-)

-- 
1.9.1


-- 
Christoffer Holmstedt
