Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:59198 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaKQHV3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:29 -0500
Received: by mail-wg0-f54.google.com with SMTP id y10so2523233wgg.41
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:28 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/13] mac802154: remove const for non pointer in rdev-ops
Date: Mon, 17 Nov 2014 08:20:47 +0100
Message-Id: <1416208855-8623-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patches removes the const keyword in variables which are non
pointers. There is no sense to declare call by value parameters as
const.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/ieee802154/rdev-ops.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index a78f700..578bc41 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -21,8 +21,7 @@ rdev_del_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
 }
 
 static inline int
-rdev_set_channel(struct cfg802154_registered_device *rdev, const u8 page,
-		 const u8 channel)
+rdev_set_channel(struct cfg802154_registered_device *rdev, u8 page, u8 channel)
 {
 	return rdev->ops->set_channel(&rdev->wpan_phy, page, channel);
 }
@@ -43,8 +42,7 @@ rdev_set_short_addr(struct cfg802154_registered_device *rdev,
 
 static inline int
 rdev_set_backoff_exponent(struct cfg802154_registered_device *rdev,
-			  struct wpan_dev *wpan_dev, const u8 min_be,
-			  const u8 max_be)
+			  struct wpan_dev *wpan_dev, u8 min_be, u8 max_be)
 {
 	return rdev->ops->set_backoff_exponent(&rdev->wpan_phy, wpan_dev,
 					       min_be, max_be);
@@ -52,8 +50,7 @@ rdev_set_backoff_exponent(struct cfg802154_registered_device *rdev,
 
 static inline int
 rdev_set_max_csma_backoffs(struct cfg802154_registered_device *rdev,
-			   struct wpan_dev *wpan_dev,
-			   const u8 max_csma_backoffs)
+			   struct wpan_dev *wpan_dev, u8 max_csma_backoffs)
 {
 	return rdev->ops->set_max_csma_backoffs(&rdev->wpan_phy, wpan_dev,
 						max_csma_backoffs);
@@ -61,8 +58,7 @@ rdev_set_max_csma_backoffs(struct cfg802154_registered_device *rdev,
 
 static inline int
 rdev_set_max_frame_retries(struct cfg802154_registered_device *rdev,
-			   struct wpan_dev *wpan_dev,
-			   const s8 max_frame_retries)
+			   struct wpan_dev *wpan_dev, s8 max_frame_retries)
 {
 	return rdev->ops->set_max_frame_retries(&rdev->wpan_phy, wpan_dev,
 						max_frame_retries);
@@ -70,7 +66,7 @@ rdev_set_max_frame_retries(struct cfg802154_registered_device *rdev,
 
 static inline int
 rdev_set_lbt_mode(struct cfg802154_registered_device *rdev,
-		  struct wpan_dev *wpan_dev, const bool mode)
+		  struct wpan_dev *wpan_dev, bool mode)
 {
 	return rdev->ops->set_lbt_mode(&rdev->wpan_phy, wpan_dev, mode);
 }
-- 
2.1.3

