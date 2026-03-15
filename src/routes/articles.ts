import { Router } from "express";
import { ResultSetHeader } from "mysql2";
import { pool } from "../database";
import { Article, ArticleWithAuthor } from "../interfaces";
import { authenticateToken } from "../middleware/auth-validation";
import {
  validateArticle,
  validatePartialArticle,
  validateArticleId,
} from "../middleware/article-validation";

const router = Router();

// get all articles
router.get("/", async (req, res) => {
  try {
    const [rows] = await pool.execute(`
        SELECT
          articles.id,
          articles.title,
          articles.body,
          articles.category,
          articles.created_at,
          users.email AS author
        FROM articles
        JOIN users ON articles.submitted_by = users.id
        ORDER BY articles.created_at DESC
      `);

    const articles = rows as ArticleWithAuthor[];

    res.json(articles);
  } catch (error) {
    console.error("Database error:", error);

    res.status(500).json({
      error: "Failed to fetch articles",
    });
  }
});

// create an article
router.post("/", authenticateToken, validateArticle, async (req, res) => {
  try {
    const { title, body, category } = req.body;

    const [result]: [ResultSetHeader, any] = await pool.execute(
      `
          INSERT INTO articles (title, body, category, submitted_by)
          VALUES (?, ?, ?, ?)
          `,
      [title, body, category, req.user!.id],
    );

    res.status(201).json({
      message: "Article created",
      articleId: result.insertId,
    });
  } catch (error) {
    console.error("Database error:", error);

    res.status(500).json({
      error: "Failed to create article",
    });
  }
});

// get a single article
router.get("/:id", validateArticleId, async (req, res) => {
  try {
    const articleId = Number(req.params.id);

    const [rows] = await pool.execute(
      `
        SELECT
          articles.id,
          articles.title,
          articles.body,
          articles.category,
          articles.created_at,
          users.email AS author
        FROM articles
        JOIN users ON articles.submitted_by = users.id
        WHERE articles.id = ?
        `,
      [articleId],
    );

    const articles = rows as ArticleWithAuthor[];

    if (articles.length === 0) {
      return res.status(404).json({
        error: "Article not found",
      });
    }

    res.json(articles[0]);
  } catch (error) {
    console.error("Database error:", error);

    res.status(500).json({
      error: "Failed to fetch article",
    });
  }
});

// update an article
router.put(
  "/:id",
  authenticateToken,
  validateArticleId,
  validateArticle,
  async (req, res) => {
    try {
      const articleId = Number(req.params.id);
      const { title, body, category } = req.body;

      const [rows] = await pool.execute(
        "SELECT submitted_by FROM articles WHERE id = ?",
        [articleId],
      );

      const articles = rows as Article[];

      if (articles.length === 0) {
        return res.status(404).json({
          error: "Article not found",
        });
      }

      if (articles[0].submitted_by !== req.user!.id) {
        return res.status(403).json({
          error: "You can only update your own articles",
        });
      }

      await pool.execute(
        `
          UPDATE articles
          SET title = ?, body = ?, category = ?
          WHERE id = ?
          `,
        [title, body, category, articleId],
      );

      res.json({
        message: "Article updated",
      });
    } catch (error) {
      console.error("Database error:", error);

      res.status(500).json({
        error: "Failed to update article",
      });
    }
  },
);

// partially update an article
router.patch(
  "/:id",
  authenticateToken,
  validateArticleId,
  validatePartialArticle,
  async (req, res) => {
    try {
      const articleId = Number(req.params.id);

      const [rows] = await pool.execute(
        "SELECT submitted_by FROM articles WHERE id = ?",
        [articleId],
      );

      const articles = rows as Article[];

      if (articles.length === 0) {
        return res.status(404).json({
          error: "Article not found",
        });
      }

      if (articles[0].submitted_by !== req.user!.id) {
        return res.status(403).json({
          error: "You can only update your own articles",
        });
      }

      const fields = [];
      const values = [];

      if (req.body.title) {
        fields.push("title = ?");
        values.push(req.body.title);
      }

      if (req.body.body) {
        fields.push("body = ?");
        values.push(req.body.body);
      }

      if (req.body.category) {
        fields.push("category = ?");
        values.push(req.body.category);
      }

      if (fields.length === 0) {
        return res.status(400).json({
          error: "No fields provided for update",
        });
      }

      values.push(articleId);

      const query = `
          UPDATE articles
          SET ${fields.join(", ")}
          WHERE id = ?
        `;

      await pool.execute(query, values);

      res.json({
        message: "Article updated",
      });
    } catch (error) {
      console.error("Database error:", error);

      res.status(500).json({
        error: "Failed to update article",
      });
    }
  },
);

// delete an article
router.delete(
  "/:id",
  authenticateToken,
  validateArticleId,
  async (req, res) => {
    try {
      const articleId = Number(req.params.id);

      const [rows] = await pool.execute(
        "SELECT submitted_by FROM articles WHERE id = ?",
        [articleId],
      );

      const articles = rows as Article[];

      if (articles.length === 0) {
        return res.status(404).json({
          error: "Article not found",
        });
      }

      if (articles[0].submitted_by !== req.user!.id) {
        return res.status(403).json({
          error: "You can only delete your own articles",
        });
      }

      await pool.execute("DELETE FROM articles WHERE id = ?", [articleId]);

      res.status(204).send();
    } catch (error) {
      console.error("Database error:", error);

      res.status(500).json({
        error: "Failed to delete article",
      });
    }
  },
);

export default router;
